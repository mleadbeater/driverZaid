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
            idx++;
        }
    }
    while (idx < [_buttons count]) {
        UIButton *btn = [_buttons objectAtIndex:idx];
        btn.hidden = YES;
        idx++;
    }
    
    char buffer [10];
    if ( [CLLocationManager locationServicesEnabled] == YES ) {
        void *requester = zmq_socket (zmq_context, ZMQ_REQ);
        zmq_connect (requester, "tcp://192.168.4.199:34231");
        zmq_send (requester, "Hello", 5, 0);
        zmq_recv (requester, buffer, 10, 0);
        self.alertA.highlighted = NO;
        zmq_close (requester);
    }
}

-(void) viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
