//
//  ExchangeRate.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRate : NSObject

@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDictionary *rates;
- (void) saveToLocal;

@end
