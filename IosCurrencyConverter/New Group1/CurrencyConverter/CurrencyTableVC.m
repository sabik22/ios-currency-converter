//
//  CountryTableViewController.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyTableVC.h"
#import "Currency.h"
#import "AppState.h"
#import "CountryCell.h"
#import "Utils.h"

@interface CurrencyTableVC()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) AppState *appState;
@property (strong, nonatomic) NSMutableArray *filteredCurrencies;
@property (strong, nonatomic) NSMutableArray *sectionKeys;
@property (strong, nonatomic) NSMutableDictionary *currencySections;
@property (assign, nonatomic) BOOL isFiltered;

@end

static NSString *nibName = @"CountryCell";

@implementation CurrencyTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencySections = [[NSMutableDictionary alloc] init];
    self.sectionKeys = [[NSMutableArray alloc] init];
    self.isFiltered = NO;
    [self setupSearchBar];
    [self setupTableViewCell];
    self.appState = [AppState instance];
    self.filteredCurrencies = self.appState.currencies;
    [self prepareSectionData];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (BOOL) isExcludedCurrency: (Currency *) currency{
    for(Currency *cur in self.excludeCurrencies){
        if([currency.countryID.uppercaseString isEqualToString:cur.countryID.uppercaseString])
            return YES;
    }
    return false;
}


- (void)prepareSectionData{
    [self.currencySections removeAllObjects];
    [self.sectionKeys removeAllObjects];
    for(Currency *currency in self.filteredCurrencies){
        NSString *key = [currency.countryName substringToIndex:1];
        if (self.currencySections[key]){
            [self.currencySections[key] addObject:currency];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:currency];
            [self.sectionKeys addObject:key];
            self.currencySections[key] = array;
        }
    }
    [self.tableView reloadData];
}


- (void) setupSearchBar{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [AppState instance].screenWidth, 30)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search by country";
    self.searchBar.layer.cornerRadius = 36 / 2;
    self.navigationItem.titleView = self.searchBar;
}

- (void) setupTableViewCell{
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionKeys.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionKeys;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionKeys[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = [self.currencySections objectForKey:self.sectionKeys[section]];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.separatorInset = UIEdgeInsetsMake(100, 0, 0, 0);
    }
    NSString *key = self.sectionKeys[indexPath.section];
    Currency *currency = self.currencySections[key][indexPath.row];
    NSString *symbol = @"";
    if (currency.currencySymbol) {
        symbol = [NSString stringWithFormat:@"(%@)",currency.currencySymbol];
    }
    cell.labelTitle.text = [NSString stringWithFormat:@"%@ %@",currency.countryName, symbol];
    NSString *imageName = [NSString stringWithFormat:@"%@.png", currency.countryID];
    [cell.imageViewIcon setImage:[UIImage imageNamed: imageName.lowercaseString]];
    [UIUtils roundImage:cell.imageViewIcon radius:15.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    cell.imageViewIcon.clipsToBounds = YES;
    cell.imageViewSelected.hidden = ![self isExcludedCurrency:currency];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Currency *currency = nil;
    currency = self.currencySections[self.sectionKeys[indexPath.section]][indexPath.row];
    [self.delegate currencyTableVC:self selectedCurrency:currency keyIndex:self.index];
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
    [self prepareSectionData];
}

@end
