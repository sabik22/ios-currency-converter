//
//  CountryTableViewController.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@protocol CurrencyTableVCDelegate <NSObject>

@required
- (void) dataFromController: (Currency *) currency;

@end

@interface CurrencyTableVC: UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, retain) NSString *viewTitle;
@property (nonatomic, weak) id <CurrencyTableVCDelegate> delegate;

@end
