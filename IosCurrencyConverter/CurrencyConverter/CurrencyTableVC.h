//
//  CountryTableViewController.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"
@class CurrencyTableVC;

@protocol CurrencyTableVCDelegate<NSObject>

@required
- (void)currencyTableVC:(CurrencyTableVC *)currencyTableVC selectedCurrency:(Currency *)currency keyIndex: (int) index;
@end

@interface CurrencyTableVC: UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) int index;
@property (nonatomic, copy) NSArray *excludeCurrencies;
@property (assign) id<CurrencyTableVCDelegate>delegate;

@end
