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

@interface CurrencyService()

// @property (copy, nonatomic)

@end

@implementation CurrencyService

NSString *urlCurrencyList = @"https://free.currencyconverterapi.com/api/v6/countries";
NSString *urlExchangeRate =@"https://free.currencyconverterapi.com/api/v6/convert?q={country_codes}&compact=y";

+ (void) fetchCurrencies {
    CurrencyService *fetchCurrency = [[CurrencyService alloc] init];
    [fetchCurrency fetchCurrenciesWithCompletionHandler:@"" success:^(NSArray *array) {
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
             for (NSString *key in results) {
                 NSDictionary *currencyDict = results[key];
                 Currency *currency = [[Currency alloc] init];
                 [currency parseFromDictionary:currencyDict];
                 [appState.currencies addObject:currency];
             }
             NSArray *sortedArray = [Utils sortArray:appState.currencies sortDescriptorWithKey:@"countryName" ascending:YES];
             appState.currencies = [NSMutableArray arrayWithArray:sortedArray];
             success(appState.currencies);
         } failure:^(NSError *error) {
             failure(error);
         }];
}

- (void)fetchExchangeRateWithCompletionHandler:(NSString *) currencyCode1
                                 currencyCode2: (NSString *) currencyCode2
                                       success:(void (^)(float exchangeRate))success
                                       failure:(void (^)(NSError *error))failure{
    NSString *countryCodes = [NSString stringWithFormat:@"%@_%@",currencyCode1,currencyCode2];
    NSString *url = [urlExchangeRate stringByReplacingOccurrencesOfString:@"{country_codes}" withString:countryCodes];
    ApiService *service = [ApiService instance];
    [service getJsonResponse:url
         success:^(NSDictionary *responseDict) {
             NSDictionary *results = responseDict[countryCodes];
             NSString *rate = results[@"val"];
             //dispatch_async(dispatch_get_main_queue(), ^{
                 success([rate floatValue]);
             //});
         } failure:^(NSError *error) {
             //dispatch_async(dispatch_get_main_queue(), ^{
                 failure(error);
             //});
             
         }];
}

@end
