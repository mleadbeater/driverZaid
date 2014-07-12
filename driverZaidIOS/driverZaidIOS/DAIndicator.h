//
//  DAIndicator.h
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAIndicator : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *setting_key;
@property (strong, nonatomic) NSString *image_name;
@property (strong, nonatomic) NSNumber *visible;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIButton *indicator_btn;

- (instancetype)init;
- (void)setKey: (NSString*) k settingKey: (NSString*) s andImageName: (NSString*)i;
- (NSDictionary*) toDictionary;
- (instancetype) initFromDictionary: (NSDictionary*) dict;

@end
