//
//  ViewController.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "DashboardViewController.h"
#import "CurrencyConverterVC.h"
#import "AppState.h"
#import "Utils.h"

@interface DashboardViewController()

@property(strong,nonatomic) AppState *appState;

@end



@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated{
     self.appState = [AppState instance];
}

- (IBAction)buttonCurrencyConverterAction:(UIButton *)sender {
    if (!self.appState.isFavoriteCurrencySelected){
        [AlertUtils showTwoActionsAlertWithTitle:@"Favorite currency" message:@"Please select your favorite currency." positiveText:@"Now" negativeText:@"Later" controller:self onAction:^(BOOL isPositive) {
            if (isPositive){
                [self selectFavoriteCurrency];
            } else {
                [self openCurrencyConverterVC];
            }
        }];
    } else {
        [self openCurrencyConverterVC];
    }
}

- (void)dataFromController:(Currency *)currency {
    self.appState.isFavoriteCurrencySelected = true;
    self.appState.defaultCurrency1 = currency;
    [self.appState saveToLocal];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self openCurrencyConverterVC];
    });
}

- (void)selectFavoriteCurrency {
    CurrencyTableVC *controller = [[CurrencyTableVC alloc] init];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)openCurrencyConverterVC {
    CurrencyConverterVC *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrencyConverterViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
}

@end
