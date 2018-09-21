//
//  Currency.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "Currency.h"

@implementation Currency

- (void)parseFromDictionary:(NSDictionary *)dictionary {
    self.countryID = dictionary[@"id"];
    self.currencyID = dictionary[@"currencyId"];
    self.currencyName = dictionary[@"currencyName"];
    self.currencySymbol = dictionary[@"currencySymbol"];
    self.countryName = dictionary[@"name"];
}

@end
