//
//  CurrencyHistoryChartVCViewController.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/2/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyHistoryChartVC.h"
#import "Charts-Swift.h"

@interface CurrencyHistoryChartVC ()
@property (strong, nonatomic) LineChartView *lineChartView;

@end

@implementation CurrencyHistoryChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lineChartView = [[LineChartView alloc] init];
    [self.view addSubview: self.lineChartView];
}


@end
