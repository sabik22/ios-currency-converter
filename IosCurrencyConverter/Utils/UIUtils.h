//
//  UIUtils.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/19/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

+ (void) roundImage: (UIImageView *) imageView
             radius:(float) radius
             border: (float) border
        borderColor: (UIColor *) borderColor;

@end
