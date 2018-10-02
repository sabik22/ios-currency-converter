//
//  CurrencyHistoryTableVCTableViewController.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/1/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyHistoryTableVC.h"
#import "CurrencyHistoryCell.h"
#import "CurrencyHistory.h"
#import "CountryCell.h"
#import "Utils.h"

@interface CurrencyHistoryTableVC ()
@property (strong, nonatomic) NSMutableArray *array;
@end

static NSString *nibName = @"CurrencyHistoryCell";
//static NSString *nibName = @"CountryCell";

@implementation CurrencyHistoryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewCell];
    [self prepareData];
    //self.tableView.backgroundColor
  }

- (void)setupTableViewCell{
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (void)prepareData{
    self.array = [[NSMutableArray alloc] init];
    for(NSString *key in self.data.allKeys){
        CurrencyHistory *history = [[CurrencyHistory alloc] init];
        history.date = [DateUtils dateFromString:key format:@"yyyy-MM-dd"];
        history.rate = [self.data[key] floatValue];
        [self.array addObject:history];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrencyHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
    CurrencyHistory *currencyHistory = self.array[indexPath.row];
    cell.labelDate.text = [DateUtils stringFromDate:currencyHistory.date format:@"yyyy-MM-dd"];
    cell.labelRate.text = [NSString stringWithFormat:@"%.2f", currencyHistory.rate];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
