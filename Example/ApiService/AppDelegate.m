//
//  AppDelegate.m
//  ApiService
//
//  Created by guoshencheng on 10/10/2015.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager GET:@"" parameters:<#(id)#> success:<#^(NSURLSessionDataTask *task, id responseObject)success#> failure:<#^(NSURLSessionDataTask *task, NSError *error)failure#>
    return YES;
}

@end
