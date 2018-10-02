//
//  CurrencyHistory.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/1/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyHistory.h"
#import "Utils.h"

@implementation CurrencyHistory

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [EncodeDecodeUtils decodeWithDecoder:decoder object:self];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [EncodeDecodeUtils encodeWithCoder:encoder object:self];
}

@end
