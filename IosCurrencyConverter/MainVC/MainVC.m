//
//  MainVC.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/25/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "MainTabBarController.h"
#import "DashboardViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc1 = [[UIStoryboard storyboardWithName:@"CurrencyConverterVC" bundle:nil] instantiateViewControllerWithIdentifier:@"CurrencyConverterVC"];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Converter" image:[UIImage imageNamed:@"converter"] tag:0];
    vc1.tabBarItem.image = [UIImage imageNamed:@".Downloads"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc1];
    navController.tabBarItem = item;

    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Favorite" image:[UIImage imageNamed:@"favorite"] tag:0];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem = item1;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:navController, vc2, nil];
    
    [self setViewControllers:viewControllers animated:YES];
}


@end
