//
//  AppState.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "AppState.h"
#import "Currency.h"
#import <UIKit/UIKit.h>

@implementation AppState

+ (instancetype) instance {
    static AppState *sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init{
    if(self = [super init]){
        self.currencies = [[NSMutableArray alloc] init];
        if (!self.defaultCurrency1) {
            self.defaultCurrency1 = [[Currency alloc] init];
            self.defaultCurrency1.currencyID = @"NPR";
            self.defaultCurrency1.countryID = @"np";
            self.defaultCurrency2.currencySymbol = @"(Rs))";
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

@end
