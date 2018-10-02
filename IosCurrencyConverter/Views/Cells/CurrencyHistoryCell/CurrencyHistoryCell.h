//
//  CurrencyHistoryCellTableViewCell.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/1/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;

@end
