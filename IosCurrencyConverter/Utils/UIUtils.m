//
//  UIUtils.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (void) roundImage: (UIView *) imageView
             radius:(float) radius
             border: (float) border
        borderColor: (UIColor *) borderColor{
    imageView.layer.cornerRadius = radius;
    imageView.layer.borderWidth = border;
    imageView.layer.borderColor = borderColor.CGColor;
}

+ (void) repositioningView: (UIView *) view vertical: (float) vertical horizontal: (float) horizontal{
    [UIView animateWithDuration:1 delay:0.05
         usingSpringWithDamping:0.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         CGRect r = [view frame];
                         r.origin.x += horizontal;
                         r.origin.y += vertical;
                         [view setFrame: r];
                     }
                     completion:nil];
}

+ (void) shakeView: (UIView *) view repeat:(int)repeat point:(float)point{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:repeat];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([view center].x - point, [view center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([view center].x + point, [view center].y)]];
    [[view layer] addAnimation:animation forKey:@"position"];
}

@end
