//
//  DateUtils.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSDate *) dateFromString: (NSString *) dateString format: (NSString *) format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:dateString];
}

+ (NSString *) stringFromDate: (NSDate *) date format: (NSString *) format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

@end
