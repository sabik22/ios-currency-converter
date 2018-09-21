//
//  AppDelegate.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "AppDelegate.h"
#import "Currency.h"
#import "CurrencyService.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [CurrencyService fetchCurrencies];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
