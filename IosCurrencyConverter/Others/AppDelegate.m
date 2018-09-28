//
//  AppDelegate.m
//  ISOCurrencyConverter
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "AppDelegate.h"
#import "Currency.h"
#import "CurrencyService.h"
#import "AppInitializer.h"
#import "MainTabBarController.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AppInitializer start];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    self.window.rootViewController = viewController;
    UINavigationBar.appearance.translucent = NO;
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:0.0f green:145.0f/255.0f blue:147.0f/255.0f alpha:1];
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.shadowImage = [[UIImage alloc] init];
    UINavigationBar.appearance.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.window makeKeyAndVisible];
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
