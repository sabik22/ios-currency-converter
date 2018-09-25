//
//  FetchCurrency.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyService.h"
#import "Currency.h"
#import "ApiService.h"
#import "AppState.h"
#import "Utils.h"
#import "ExchangeRate.h"

@interface CurrencyService()

@end

@implementation CurrencyService

NSString *urlCurrencyList = @"https://free.currencyconverterapi.com/api/v6/countries";
NSString *urlBaseExchangeRate = @"http://data.fixer.io/api/latest?access_key=1cc3b37fd4fbbe47ceb38c554a4280c5&format=1";

+ (void) fetchCurrencies {
    CurrencyService *fetchCurrency = [[CurrencyService alloc] init];
    [fetchCurrency fetchCurrenciesWithCompletionHandler:@"" success:^(NSArray *array) {
    } failure:^(NSError *error) {
    }];
}

+ (void) fetchBaseExhangeRates{
    NSLog(@"Fetching BaseExchangeRates");
    ApiService *service = [ApiService instance];
    [service getJsonResponse:urlBaseExchangeRate
                     success:^(NSDictionary *responseDict) {
                         NSString *dateString = responseDict[@"date"];
                         NSLog(@"Date :: %@",dateString);
                         
                         NSDictionary *rates = responseDict[@"rates"];
                         NSLog(@"Date :: %d",(int) rates.count);
                         
                         ExchangeRate *exchangeRate = [[ExchangeRate alloc] init];
                         exchangeRate.date= [DateUtils dateFromString:dateString format:@"yyyy-MM-dd"];
                         exchangeRate.rates = rates;
                         [exchangeRate saveToLocal];
                     } failure:^(NSError *error) {
                         
                     }];
}

- (void) fetchCurrenciesWithCompletionHandler: (NSString *) empty
                                      success:(void (^)(NSArray *array))success
                                      failure: (void (^)(NSError *error))failure{
    ApiService *service = [ApiService instance];
    [service getJsonResponse:urlCurrencyList
         success:^(NSDictionary *responseDict) {
             NSDictionary *results = responseDict[@"results"];
             AppState *appState=[AppState instance];
             appState.currencies = [[NSMutableArray alloc] init];
             for (NSString *key in results) {
                 NSDictionary *currencyDict = results[key];
                 Currency *currency = [[Currency alloc] init];
                 [currency parseFromDictionary:currencyDict];
                 [appState.currencies addObject:currency];
             }
             NSArray *sortedArray = [Utils sortArray:appState.currencies sortDescriptorWithKey:@"countryName" ascending:YES];
             appState.currencies = [NSMutableArray arrayWithArray:sortedArray];
             [appState saveToLocal];
             success(appState.currencies);
         } failure:^(NSError *error) {
             failure(error);
         }];
}

- (void)fetchExchangeRateWithCompletionHandler:(NSString *) currencyCode1
                                 currencyCode2: (NSString *) currencyCode2
                                       success:(void (^)(float exchangeRate))success
                                       failure:(void (^)(NSError *error))failure{
    NSString *date = [DateUtils stringFromDate:[NSDate date]  format:@"yyyy-MM-dd"];
    NSString *key = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([ExchangeRate class]),date];
    ExchangeRate *rate = (ExchangeRate *) [NSUserDefaultsUtils getWithKey:key];
    if (rate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float rateOne = [rate.rates[currencyCode1] floatValue];
            float rateTwo = [rate.rates[currencyCode2] floatValue];
            success(rateTwo/rateOne);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"ran out of money" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"world" code:200 userInfo:details];
            failure(error);
        });
    }
    
}




@end
