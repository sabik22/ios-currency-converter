//
//  UIUtils.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (void) roundImage: (UIImageView *) imageView
             radius:(float) radius
             border: (float) border
        borderColor: (UIColor *) borderColor{
    imageView.layer.cornerRadius = radius;
    imageView.layer.borderWidth = border;
    imageView.layer.borderColor = borderColor.CGColor;
}

@end
