//
//  AppState.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Currency;

@interface AppState : NSObject

+ (instancetype) instance;
@property (nonatomic, strong)  NSMutableArray *currencies;
@property (nonatomic, strong)  Currency *defaultCurrency1;
@property (nonatomic, strong)  Currency *defaultCurrency2;
@property (nonatomic, assign)  float screenWidth;
@property (nonatomic, assign)  float screenHeight;
@property (nonatomic, assign)  BOOL isFavoriteCurrencySelected;

@end
