//
//  AppState.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <objc/runtime.h>
#import "AppState.h"
#import "Currency.h"
#import <UIKit/UIKit.h>
#import "Utils.h"
#import "EncodeDecodeUtils.h"

@implementation AppState

+ (instancetype) instance {
    static AppState *sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)saveToLocal {
    [NSUserDefaultsUtils setObject:self key:NSStringFromClass([AppState class])];
}

- (instancetype) init{
    NSLog(@"-----1--------");
    AppState *appState = (AppState *) [NSUserDefaultsUtils getWithKey:NSStringFromClass([AppState class])];
    NSLog(@"-----2--------");
    if(appState){
        self = appState;
        NSLog(@"-----3--------");
        return self;
    }
    if(self = [super init]){
        self.currencies = [[NSMutableArray alloc] init];
        if (!self.defaultCurrency1) {
            self.defaultCurrency1 = [[Currency alloc] init];
            self.defaultCurrency1.currencyID = @"NPR";
            self.defaultCurrency1.countryID = @"np";
            self.defaultCurrency2.currencySymbol = @"Rs";
        }
        if (!self.defaultCurrency2){
            self.defaultCurrency2 = [[Currency alloc]init];
            self.defaultCurrency2.currencyID = @"USD";
            self.defaultCurrency2.countryID = @"us";
            self.defaultCurrency2.currencySymbol = @"$";
        }
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.screenWidth = screenRect.size.width;
    self.screenHeight = screenRect.size.height;
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [EncodeDecodeUtils decodeWithDecoder:decoder object:self];
    }
    //    if (self = [super init]) {
    //        self.currencies = [decoder decodeObjectForKey:@"currencies"];
    //        self.defaultCurrency1 = [decoder decodeObjectForKey:@"defaultCurrency1"];
    //        self.defaultCurrency2 = [decoder decodeObjectForKey:@"defaultCurrency2"];
    //        self.screenWidth = [decoder decodeFloatForKey:@"screenWidth"];
    //        self.screenHeight = [decoder decodeFloatForKey:@"screenHeight"];
    //        self.isFavoriteCurrencySelected = [decoder decodeBoolForKey:@"isFavoriteCurrencySelected"];
    //    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [EncodeDecodeUtils encodeWithCoder:encoder object: self];
//    [encoder encodeObject:self.currencies forKey:@"currencies"];
//    [encoder encodeObject:self.defaultCurrency1 forKey:@"defaultCurrency1"];
//    [encoder encodeObject:self.defaultCurrency2 forKey:@"defaultCurrency2"];
//    [encoder encodeFloat:self.screenWidth forKey:@"screenWidth"];
//    [encoder encodeFloat:self.screenHeight forKey:@"screenHeight"];
//    [encoder encodeBool:self.isFavoriteCurrencySelected forKey:@"isFavoriteCurrencySelected"];
}

@end
