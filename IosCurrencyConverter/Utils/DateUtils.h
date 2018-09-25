//
//  DateUtils.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDate *) dateFromString: (NSString *) dateString format: (NSString *) format;
+ (NSString *) stringFromDate: (NSDate *) date format: (NSString *) format;


@end
