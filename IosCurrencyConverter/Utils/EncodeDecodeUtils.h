//
//  EncodeDecodeUtils.h
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EncodeDecodeUtils : NSObject

+ (id) decodeWithDecoder:(NSCoder *)decoder object:(NSObject *) object;
+ (void) encodeWithCoder:(NSCoder *)encoder object:(NSObject *) object;

@end
