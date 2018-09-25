//
//  Utils.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertUtils.h"
#import "UIUtils.h"
#import "AppState.h"
#import "NSUserDefaultsUtils.h"
#import "DateUtils.h"
#import "EncodeDecodeUtils.h"

@interface Utils : NSObject

+ (NSArray *) sortArray: (NSArray *) array sortDescriptorWithKey: (NSString *) key ascending:(BOOL) ascending;

@end
