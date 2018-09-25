//
//  ExchangeRate.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "ExchangeRate.h"
#import "Utils.h"

@implementation ExchangeRate

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        [EncodeDecodeUtils decodeWithDecoder:coder object:self];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [EncodeDecodeUtils encodeWithCoder:encoder object: self];
}

- (void)saveToLocal {
    NSString *date = [DateUtils stringFromDate:[NSDate date] format:@"yyyy-MM-dd"];
    NSString *key = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([ExchangeRate class]),date];
    NSLog(@"%@",key);
    [NSUserDefaultsUtils setObject:self key:key];
}

@end
