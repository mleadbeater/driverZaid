//
//  DAOptions.h
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAOptions : NSObject

@property (strong, nonatomic) NSDictionary *options;
@property (strong, nonatomic) NSArray *categories;

-(instancetype) init;
-(void) save;

@end
