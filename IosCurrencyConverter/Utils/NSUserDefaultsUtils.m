//
//  NSUserDefaultsUtils.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/22/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "NSUserDefaultsUtils.h"
#import "AppState.h"

@implementation NSUserDefaultsUtils

+ (id) getWithKey: (NSString *) key{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *data = [prefs objectForKey:key];
    NSObject *object= [NSKeyedUnarchiver unarchiveObjectWithData: data];
    return object;
}

+ (void) setObject: (id) object key:(NSString *) key{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *encodeData = [NSKeyedArchiver archivedDataWithRootObject: object];
    [prefs setObject:encodeData forKey:key];
}

@end
