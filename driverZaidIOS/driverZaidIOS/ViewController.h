//
//  ViewController.h
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class DAOptions;

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblSpeedLimit;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong) NSArray *indicators;
@property (weak, nonatomic) IBOutlet UIButton *alertA;
@property (weak, nonatomic) IBOutlet UIButton *alertB;
@property (weak, nonatomic) IBOutlet UIButton *alertC;
@property (weak, nonatomic) IBOutlet UIButton *alertD;
@property (weak, nonatomic) IBOutlet UIButton *alertE;
@property (weak, nonatomic) IBOutlet UIButton *alertF;
@property (weak, nonatomic) IBOutlet UIButton *alertG;
@property (weak, nonatomic) IBOutlet UIButton *alertH;
@property (weak, nonatomic) IBOutlet UIButton *alertI;
@property (weak, nonatomic) IBOutlet UIButton *alertJ;
@property (weak, nonatomic) IBOutlet UIButton *alertK;
@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) DAOptions *options;

@property (strong, nonatomic) CLLocationManager *locationManager;

- (void)startStandardUpdates;
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations;
@end
