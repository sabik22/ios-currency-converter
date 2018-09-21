//
//  CountryTableViewController.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyTableVC.h"
#import "../Model/Currency.h"
#import "AppState.h"
#import "CountryCell.h"
#import "Utils.h"

@interface CurrencyTableVC()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) AppState *appState;
@property (strong, nonatomic) NSMutableArray *filteredCurrencies;
@property (assign, nonatomic) BOOL isFiltered;

@end

static NSString *nibName = @"CountryCell";

@implementation CurrencyTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFiltered = NO;
    [self setupSearchBar];
    [self setupTableViewCell];
    self.appState = [AppState instance];
    self.filteredCurrencies = self.appState.currencies;
}

- (void) setupSearchBar{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [AppState instance].screenWidth, 44.0f)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search by country";
    self.navigationItem.titleView = self.searchBar;
    //self.tableView.tableHeaderView = self.searchBar;
}

- (void) setupTableViewCell{
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredCurrencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
    Currency *currency = self.filteredCurrencies[indexPath.row];
    NSString *symbol = @"";
    if (currency.currencySymbol) {
        symbol = [NSString stringWithFormat:@"(%@)",currency.currencySymbol];
    }
    cell.labelTitle.text = [NSString stringWithFormat:@"%@ %@",currency.countryName, symbol];
    NSString *imageName = [NSString stringWithFormat:@"%@.png", currency.countryID];
    [cell.imageViewIcon setImage:[UIImage imageNamed: imageName.lowercaseString]];
    [UIUtils roundImage:cell.imageViewIcon radius:15.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    cell.imageViewIcon.clipsToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Currency *currency = nil;
    currency = self.filteredCurrencies[indexPath.row];
    [self.delegate dataFromController: currency];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        self.isFiltered = NO;
        self.filteredCurrencies = self.appState.currencies;
    } else {
        self.isFiltered = YES;
        self.filteredCurrencies = [[NSMutableArray alloc] init];
        for (Currency *currency in self.appState.currencies) {
            NSRange rangeCurrency =  [currency.countryName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (rangeCurrency.location != NSNotFound) {
                [self.filteredCurrencies addObject:currency];
            }
        }
    }
    [self.tableView reloadData];
}

@end
