//
//  DAIndicator.m
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import "DAIndicator.h"

@implementation DAIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.visible = [NSNumber numberWithBool:YES];
    }
    return self;
}
- (instancetype) initFromDictionary: (NSDictionary*) dict
{
    self = [super init];
    if (self) {
        self.key = [dict objectForKey:@"key"];
        self.setting_key = [dict objectForKey:@"setting_key"];
        self.image_name = [dict objectForKey:@"image_name"];
        if ( [dict objectForKey:@"visible"] == nil) self.visible = [NSNumber numberWithBool:YES];
    }
    return self;
}

- (void)setKey: (NSString*) k settingKey: (NSString*) s andImageName: (NSString*)i
{
    self.key = k;
    self.setting_key = s;
    self.image_name = i;
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.key forKey:@"key"];
    [dict setObject:self.setting_key forKey:@"setting_key"];
    [dict setObject:self.image_name forKey:@"image_name"];
    [dict setObject:self.visible forKey:@"visible"];
    return [[NSDictionary alloc] initWithDictionary:dict];
}

@end
