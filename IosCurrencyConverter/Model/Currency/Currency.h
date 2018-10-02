//
//  Currency.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency: NSObject

@property (nonatomic,strong) NSString *countryID;
@property (nonatomic,strong) NSString *countryName;
@property (nonatomic,strong) NSString *currencyName;
@property (nonatomic,strong) NSString *currencySymbol;
@property (nonatomic,strong) NSString *currencyID;

- (void)parseFromDictionary:(NSDictionary *)dictionary;

@end
