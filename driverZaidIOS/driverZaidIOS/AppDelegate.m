//
//  AppDelegate.m
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DAOptions.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    zmq_context = zmq_ctx_new();
    //ViewController* mainController = (ViewController*)  self.window.rootViewController;
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsURLKey] != nil) {
        // ref https://developer.apple.com/library/ios/documentation/userexperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html#//apple_ref/doc/uid/TP40009497-CH2-SW2
        ViewController* mainController = (ViewController*)  self.window.rootViewController;
        mainController.locationManager = nil;
        [mainController startStandardUpdates];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    ViewController* mainController = (ViewController*)  self.window.rootViewController;
    [mainController.options save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    ViewController* mainController = (ViewController*)  self.window.rootViewController;
    [mainController.options save];
    zmq_ctx_destroy(zmq_context);
}

@end
