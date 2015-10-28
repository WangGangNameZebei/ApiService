//
//  ApiRequest+BuildFactory.m
//  ApiService
//
//  Created by guoshencheng on 10/10/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import "ApiRequest+BuildFactory.h"
#import "NSDictionary+ApiService.h"

@implementation ApiRequest (BuildFactory)

+ (instancetype)requestForGet {
    ApiRequest *request = [ApiRequest defaultRequest];
    request.url = @"http://127.0.0.1:3000/example/1";
    request.parameters = nil;
    return request;
}

+ (instancetype)requestForPost {
    ApiRequest *request = [ApiRequest defaultRequest];
    request.url = @"http://127.0.0.1:3000/example/2";
    request.method = ApiRequestMethodPost;
    request.parameters = [@{@"example" : @"post example"} toWebServerParameters];
    return request;
}

+ (instancetype)requestForDelete {
    ApiRequest *request = [ApiRequest defaultRequest];
    request.url = @"http://127.0.0.1:3000/example";
    request.method = ApiRequestMethodDelete;
    request.parameters = nil;
    return request;
}

+ (instancetype)requestForPut {
    ApiRequest *request = [ApiRequest defaultRequest];
    request.url = @"http://127.0.0.1:3000/example";
    request.method = ApiRequestMethodPut;
    request.parameters = [@{@"example" : @"put example"} toWebServerParameters];
    return request;
}

+ (instancetype)requestForMultiparty {
    ApiRequest *request = [self defaultRequest];
    request.method = ApiRequestMethodMutipartPost;
    request.url = @"http://127.0.0.1:3000/upload";
    request.parameters = nil;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"SF" ofType:@"png"];
    UIImage *image = [UIImage imageNamed:@"SF.png"];
    NSData *data = UIImagePNGRepresentation(image);
    request.files = [[NSMutableArray alloc] initWithArray:@[imagePath, data]];
    return request;
}

+ (instancetype)defaultRequest {
    ApiRequest *request = [[ApiRequest alloc] init];
    request.method = ApiRequestMethodGet;
    request.parameters = [NSMutableDictionary dictionary];
    return request;
}

@end
