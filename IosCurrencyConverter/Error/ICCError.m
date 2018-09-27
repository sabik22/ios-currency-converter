//
//  ICCError.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/25/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "ICCError.h"

NSString * const Domain = @"com.bikashshrestha.ios-currency-converter";

@implementation ICCError

+ (NSString *) domain {
    return Domain;
}

+ (NSError *) dataNotFound{
    NSString *desc = NSLocalizedString(@"Data not found", @"");
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    return [self errorWithErrorCode:1 userInfo:userInfo];
}

+ (NSError *)errorWithErrorCode:(NSInteger)errorCode{
    return [NSError errorWithDomain:Domain code:errorCode userInfo:nil];
}
+ (NSError *)errorWithErrorCode:(NSInteger)errorCode userInfo:(NSDictionary *)userInfo{
    return [NSError errorWithDomain:Domain code:errorCode userInfo:userInfo];
}

@end
