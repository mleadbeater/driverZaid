//
//  ViewController.m
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import "ViewController.h"
#import "zmq.h"
#import "DAOptions.h"
#import "DAIndicator.h"
#import <CoreLocation/CoreLocation.h>

extern void *zmq_context;
void *api_socket = 0;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.options = [[DAOptions alloc] init];
    self.buttons = [[NSArray alloc] initWithObjects:_alertA,
                    _alertB, _alertC, _alertD, _alertE, _alertF, _alertG,
                    _alertH, _alertI, _alertJ, _alertK,
                    nil];
    
    int idx = 0;
    for (NSString *item in self.options.categories) {
        DAIndicator *ind = [self.options.options objectForKey:item];
        if ([ind.visible intValue]) {
            UIButton *btn = [self.buttons objectAtIndex:idx];
            btn.imageView.image = [UIImage imageNamed:ind.image_name];
            btn.hidden = NO;
            ind.indicator_btn = btn;
            idx++;
        }
    }
    while (idx < [_buttons count]) {
        UIButton *btn = [_buttons objectAtIndex:idx];
        btn.hidden = YES;
        idx++;
    }
    
}

-(void) viewWillAppear:(BOOL)animated {
    char buffer [10];
    if ( [CLLocationManager locationServicesEnabled] == YES ) {
        api_socket = zmq_socket (zmq_context, ZMQ_REQ);
        zmq_connect (api_socket, "tcp://122.248.252.183:34231");
        zmq_send (api_socket, "Hello", 5, 0);
        zmq_recv (api_socket, buffer, 10, 0);
        [self startStandardUpdates];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    if (api_socket) zmq_close (api_socket);
    api_socket = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 1.; // meters
    
    [_locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        char incoming[200];
        char outgoing[50];
        snprintf(outgoing, 50, "%+.6lf %+.6lf", location.coordinate.latitude, location.coordinate.longitude);
        zmq_send (api_socket, outgoing, strlen(outgoing), 0);
        int len = zmq_recv (api_socket, incoming, 100, 0);
        if (len) {
            incoming[len] = 0;
            NSLog(@"%@", [NSString stringWithUTF8String:incoming]);
            NSError* error;
            NSDictionary *loaded = [NSJSONSerialization
                                    JSONObjectWithData:[NSData dataWithBytes:incoming length:len]
                                    options:kNilOptions
                                    error:&error];
            for (NSString *key in loaded) {
                if ([key compare:@"limit"] == 0) {
                    self.lblSpeedLimit.text = [loaded objectForKey:key];
                    NSLog(@"speed limit: %@", [loaded objectForKey:key]);
                }
                else if ([key compare:@"indicators"] == 0) {
                    for (NSString *item in self.options.categories) {
                        DAIndicator *ind = [self.options.options objectForKey:item];
                        if ([ind.visible intValue]) {
                            ind.indicator_btn.enabled = NO;
                            ind.indicator_btn.highlighted = YES;
                        }
                    }
                    NSArray *indicators = [loaded objectForKey:key];
                    for (NSString *ind_str in indicators) {
                        DAIndicator *ind = [self.options.options objectForKey:ind_str];
                        if (ind) {
                            if (ind.visible) {
                                if (!ind.indicator_btn) NSLog(@"indicator %@ does not have a button", ind_str);
                                NSLog(@"showing %@", ind_str);
                                ind.indicator_btn.enabled = YES;
                                ind.indicator_btn.highlighted = NO;
                            }
                            else
                                NSLog(@"not displaying %@", ind_str);
                            
                        }
                        else
                            NSLog(@"unknown key %@", ind_str);
                        
                    }
                }
            }
        }
        else {
            NSLog(@"server communication error getting response");
        }
    }
}

@end
