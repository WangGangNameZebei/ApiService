//
//  AppDelegate.m
//  ApiService
//
//  Created by guoshencheng on 10/10/2015.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "DemoViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager GET:@"http://127.0.0.1:3000/example" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//
//    [manager POST:@"http://127.0.0.1:3000/example" parameters:@{@"example" : @"post example"} success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
//    [manager PUT:@"http://127.0.0.1:3000/example" parameters:@{@"example" : @"put example"} success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    [manager DELETE:@"http://127.0.0.1:3000/example" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"SF" ofType:@"png"];
//    UIImage *image = [UIImage imageNamed:@"SF.png"];
//    NSData *data = UIImagePNGRepresentation(image);
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://127.0.0.1:3000/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imagePath] name:@"file1" fileName:@"filename1.jpg" mimeType:@"image/jpeg" error:nil];
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imagePath] name:@"file2" fileName:@"filename2.jpg" mimeType:@"image/jpeg" error:nil];
//        [formData appendPartWithFileData:data name:@"file3" fileName:@"filename3.jpg" mimeType:@"image/jpeg" ];
//    } error:nil];
//    
//    NSProgress *progress = nil;
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
    
    return YES;
}

@end
