//
//  ApiService.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/18/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ApiService.h"

@implementation ApiService

+ (instancetype) instance {
    static ApiService *sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) getJsonResponse:(NSString *) urlStr
                success:(FANetworksuccessBlock)success
                failure:(FANetworkErrorBlock)failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                });
                                                if (error) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        failure(error);
                                                    });
                                                } else {
                                                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        success(dictionary);
                                                    });
                                                }
                                            }];
    [dataTask resume];
}

@end
