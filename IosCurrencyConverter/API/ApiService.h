//
//  ApiService.h
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FANetworksuccessBlock)(NSDictionary *responseDict);
typedef void (^FANetworkErrorBlock)(NSError *error);

@interface ApiService : NSObject

+ (instancetype) instance;

-(void) getJsonResponse:(NSString *) urlStr
                success:(FANetworksuccessBlock)success
                failure:(FANetworkErrorBlock)failure;

@end
