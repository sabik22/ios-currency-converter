//
//  ICCError.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/25/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICCError : NSObject

+ (NSError *)dataNotFound;

+ (NSError *)errorWithErrorCode:(NSInteger)errorCode; // << user info would be nil
+ (NSError *)errorWithErrorCode:(NSInteger)errorCode userInfo:(NSDictionary *)userInfo;

@end

extern NSString * const Domain;

typedef enum ICCErrorCode {
    ICCErrorCode_Undefined = 0,
    ICCErrorCode_DataNotFound
} ICCErrorCode;
