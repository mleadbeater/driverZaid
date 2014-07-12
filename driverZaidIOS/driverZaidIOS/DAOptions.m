//
//  DAOptions.m
//  driverZaidIOS
//
//  Created by Martin on 12/07/2014.
//  Copyright (c) 2014 Martin. All rights reserved.
//

#import "DAOptions.h"
#import "DAIndicator.h"

BOOL needSave = NO;

@implementation DAOptions

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        NSString *settingsPath = [rootPath stringByAppendingPathComponent:@"settings.json"];
        NSData *settingsJSON = [[NSFileManager defaultManager] contentsAtPath:settingsPath];
        NSError* error;
        NSMutableDictionary *opts = nil;
        if (settingsJSON != nil) {
            NSDictionary *loaded = [NSJSONSerialization
                              JSONObjectWithData:settingsJSON
                              options:kNilOptions
                              error:&error];
            opts = [[NSMutableDictionary alloc] initWithDictionary:loaded];
        }
        if (opts) { // convert the loaded dictionaries to our objects
            NSMutableDictionary *indicators = [[NSMutableDictionary alloc] init];
            for (NSString *key in opts) {
                NSDictionary *dict = [opts objectForKey:key];
                DAIndicator *ind = [[DAIndicator alloc] init];
                [ind setKey:[dict objectForKey:@"key"]
                 settingKey:[dict objectForKey:@"setting_key"] andImageName:[dict objectForKey:@"image_name"]];
                [indicators setObject:ind forKey:key];
            }
            opts = indicators;
        }
        opts = [[NSMutableDictionary alloc] init];
        
        /* Make sure all our objects are loaded */
        self.categories = [[NSArray alloc] initWithObjects:
            @"RoadQuality", @"BikeLanes", @"AccidentHotSpot",
            @"Info", @"PublicTransport", @"KnownRadar", @"AnimalCross",
            @"Caution", @"CarPark", @"Crossing", @"RoadBlock", nil];
        for (NSString *item in self.categories) {
            NSString *setting = [NSString stringWithFormat:@"Show%@",item];
            NSString *img = [NSString stringWithFormat: @"%@.png",[item lowercaseString] ];
            if ([opts objectForKey:item] == nil) {
                DAIndicator *ind = [[DAIndicator alloc] init];
                [ind setKey:item settingKey:setting andImageName:img];
                ind.visible = [NSNumber numberWithBool:(1 ? YES : NO)];
                [opts setValue:ind forKey:item];
                needSave = YES;
            }
        }
        _options = [[NSDictionary alloc] initWithDictionary:opts];
        
        // setup icons
        for (NSString *key in _options) {
            DAIndicator *ind = [_options objectForKey:key];
            NSLog(@"%@ %@", ind.key, ind.visible);
        }
    }
    return self;
}

- (void) save
{
    if (needSave) {
        NSString *error;
        NSError *err;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"settings.json"];
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        for (NSString *key in _options) {
            DAIndicator *ind = [_options objectForKey:key];
            [opts setObject:[ind toDictionary] forKey:key];
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:opts options:kNilOptions error:&err];
        if(jsonData) {
            [jsonData writeToFile:plistPath atomically:YES];
        }
        else {
            NSLog(@"%@",error);
        }
        needSave = NO;
    }
}
@end
