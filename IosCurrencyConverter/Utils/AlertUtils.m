//
//  AlertUtils.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "AlertUtils.h"

@implementation AlertUtils

+ (void) showAlert: (NSString *) message duration: (int) duration controller: (UIViewController *) controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [controller presentViewController:alert
                             animated:YES
                           completion:nil];
    //int duration = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}


+ (void) showOneActionAlertWithTitle: (NSString *) title
                             message: (NSString *) message
                         actionTitle: (NSString *) actionTitle
                          controller:(UIViewController *) controller
                            onAction:(UIAlertActionBlock) onAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertButton = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        onAction(YES);
    }];
    [alert addAction:alertButton];
    [controller presentViewController:alert animated:YES completion:nil];
}

+ (void) showTwoActionsAlertWithTitle: (NSString *) title
                              message: (NSString *) message
                         positiveText: (NSString *) positiveText
                         negativeText: (NSString *) negativeText
                           controller:(UIViewController *) controller
                             onAction:(UIAlertActionBlock) onAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:positiveText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        onAction(YES);
    }];
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:negativeText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        onAction(NO);
    }];
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
