//
//  CurrencyHistory.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/1/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyHistory : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) float rate;
@end
