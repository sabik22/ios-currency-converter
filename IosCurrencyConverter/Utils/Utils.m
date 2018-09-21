//
//  Utils.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>

@implementation Utils

+ (NSArray *) sortArray: (NSArray *) array sortDescriptorWithKey: (NSString *) key ascending:(BOOL) ascending{
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:key
                                                                 ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    return [array sortedArrayUsingDescriptors:sortDescriptors];
}

@end
