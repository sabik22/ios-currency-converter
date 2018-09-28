//
//  UIUtils.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

+ (void) roundImage: (UIView *) imageView
             radius:(float) radius
             border: (float) border
        borderColor: (UIColor *) borderColor;

+ (void) repositioningView: (UIView *) view vertical: (float) vertical horizontal: (float) horizontal;

+ (void) shakeView: (UIView *) view repeat:(int)repeat point:(float)point;

@end
