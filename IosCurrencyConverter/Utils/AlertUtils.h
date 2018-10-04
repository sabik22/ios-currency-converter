//
//  AlertUtils.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertActionBlock)(BOOL isPositive);

@interface AlertUtils : NSObject

+ (void) showAlert: (NSString *) message duration: (int) duration
        controller:(UIViewController *) controller;

+ (void) showOneActionAlertWithTitle: (NSString *) title
                             message: (NSString *) message
                         actionTitle: (NSString *) actionOneText
                          controller:(UIViewController *)

controller onAction:(UIAlertActionBlock) onAction;

+ (void) showTwoActionsAlertWithTitle: (NSString *) title
                              message: (NSString *) message
                         positiveText: (NSString *) positiveText
                         negativeText: (NSString *) negativeText
                           controller:(UIViewController *) controller
                             onAction:(UIAlertActionBlock) onAction;

@end
