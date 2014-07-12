//
//  ViewController.m
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import "ViewController.h"
#import "zmq.h"

extern void *zmq_context;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.alertA.highlighted = YES;
    char buffer [10];
    void *requester = zmq_socket (zmq_context, ZMQ_REQ);
    zmq_connect (requester, "tcp://api.driverzaid.com:34231");
    zmq_send (requester, "Hello", 5, 0);
    zmq_recv (requester, buffer, 10, 0);
    self.alertA.highlighted = NO;
    zmq_close (requester);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
