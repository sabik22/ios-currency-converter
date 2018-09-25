//
//  NSUserDefaultsUtils.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/22/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsUtils : NSObject

+ (id) getWithKey: (NSString *) key;
+ (void) setObject: (id) object key:(NSString *) key;

@end
