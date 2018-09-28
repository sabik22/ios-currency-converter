//
//  MainVC.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/25/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *currencyNavigationController = [[UIStoryboard storyboardWithName:@"CurrencyConverterVC" bundle:nil] instantiateViewControllerWithIdentifier:@"Nav"];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Converter" image:[UIImage imageNamed:@"converter"] tag:0];
    currencyNavigationController.tabBarItem = item;

    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Favorite" image:[UIImage imageNamed:@"favorite"] tag:0];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem = item1;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:currencyNavigationController, vc2, nil];
    
    [self setViewControllers:viewControllers animated:YES];
}


@end
