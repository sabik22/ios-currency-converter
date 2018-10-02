//
//  Currency.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "Currency.h"
#import "EncodeDecodeUtils.h"

@implementation Currency

- (void)parseFromDictionary:(NSDictionary *)dictionary {
    self.countryID = dictionary[@"id"];
    self.currencyID = dictionary[@"currencyId"];
    self.currencyName = dictionary[@"currencyName"];
    self.currencySymbol = dictionary[@"currencySymbol"];
    self.countryName = dictionary[@"name"];
}

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
