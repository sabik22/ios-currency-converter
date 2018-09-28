//
//  AppInitializer.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "AppInitializer.h"
#import "AppState.h"
#import "CurrencyService.h"
#import "Utils.h"
#import "ExchangeRate.h"

@implementation AppInitializer

+ (void) start{
    [self initAppState];
    [self initBaseRate];
}

+ (void) initAppState {
    AppState *appState = [AppState instance];
    if(appState.currencies.count == 0){
        [CurrencyService fetchCurrencies];
        
    }
}

+ (void) initBaseRate {
    NSString *date = [DateUtils stringFromDate:[NSDate date]  format:@"yyyy-MM-dd"];
    NSString *key = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([ExchangeRate class]),date];
    NSLog(@"---%@",key);
    ExchangeRate *rate = (ExchangeRate *) [NSUserDefaultsUtils getWithKey:key];
    if(!rate){
        [CurrencyService fetchBaseExhangeRates];
    }
}

@end
