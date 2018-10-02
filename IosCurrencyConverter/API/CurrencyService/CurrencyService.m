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
#import "ICCError.h"

@interface CurrencyService()

@end

@implementation CurrencyService

NSString *urlCurrencyList = @"https://free.currencyconverterapi.com/api/v6/countries";
NSString *urlBaseExchangeRate = @"http://data.fixer.io/api/latest?access_key=1cc3b37fd4fbbe47ceb38c554a4280c5&format=1";
NSString *urlCurrencyHistory = @"https://free.currencyconverterapi.com/api/v6/convert?q={firstCombination},{secondCombination}&compact=ultra&date={fromDate}&endDate={toDate}";

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
                                      success:(void (^)(NSArray *dictionary))success
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

- (void)fetchExchangeRateWithFirstCurrency:(NSString *) firstCurrency
                            secondCurrency: (NSString *) secondCurrency
                                   success:(void (^)(float exchangeRate))success
                                   failure:(void (^)(NSError *error))failure{
    NSString *date = [DateUtils stringFromDate:[NSDate date]  format:@"yyyy-MM-dd"];
    NSString *key = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([ExchangeRate class]),date];
    ExchangeRate *rate = (ExchangeRate *) [NSUserDefaultsUtils getWithKey:key];
    if (rate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float rateOne = [rate.rates[firstCurrency] floatValue];
            float rateTwo = [rate.rates[secondCurrency] floatValue];
            success(rateTwo/rateOne);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure([ICCError dataNotFound]);
        });
    }
    
}

- (void)fetchOneWeekHsitoryWithFirstCurrency:(NSString *) firstCurrency
                       secondCurrency: (NSString *) secondCurrency
                              success:(void (^)(NSDictionary *dictionary))success
                              failure:(void (^)(NSError *error))failure{
    NSString *url = urlCurrencyHistory;
    url = [url stringByReplacingOccurrencesOfString:@"{firstCombination}" withString:[
           NSString stringWithFormat:@"%@_%@",firstCurrency,secondCurrency]];
    url = [url stringByReplacingOccurrencesOfString:@"{secondCombination}" withString:[
           NSString stringWithFormat:@"%@_%@",secondCurrency,firstCurrency]];
    NSDate *toDate = [[NSDate date] dateByAddingTimeInterval:-1*24*60*60];
    NSDate *fromDate = [toDate dateByAddingTimeInterval:-6*24*60*60];
    NSString *toDateString = [DateUtils stringFromDate:toDate  format:@"yyyy-MM-dd"];
    NSString *fromDateString = [DateUtils stringFromDate:fromDate  format:@"yyyy-MM-dd"];
    url = [url stringByReplacingOccurrencesOfString:@"{fromDate}" withString:fromDateString];
    url = [url stringByReplacingOccurrencesOfString:@"{toDate}" withString:toDateString];
    
    
    ApiService *service = [ApiService instance];
    [service getJsonResponse:url
                     success:^(NSDictionary *responseDict) {
//                         NSString *key = [NSString stringWithFormat:@"%@-%@",firstCurrency,secondCurrency];
//                         NSDictionary *results = responseDict[key];
//                         NSArray *array = [[NSArray alloc] init];
//                         for(NSString *key in results.allKeys){
//
//                         }
                            success(responseDict);
                     } failure:^(NSError *error) {
                         failure(error);
                     }];
    
}




@end
