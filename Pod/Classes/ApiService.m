//
//  ApiService.m
//  ArchitectureProject
//
//  Created by guoshencheng on 6/16/15.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import "ApiService.h"
#import "AFNetworking.h"
#import "NSDictionary+ApiService.h"

@implementation ApiService

#pragma mark - Public Methods

+ (instancetype)serviceWithDelegate:(id<ApiServiceDelegate>)delegate {
    ApiService *service = [[self alloc] init];
    service.delegate = delegate;
    return service;
}

- (void)sendReLoginWithRequest:(ApiRequest *)apiRequest andLoginRequest:(ApiRequest *)reloginRequest {
    [self sendPostRequest:reloginRequest withCompletion:^(id data, NSError *error) {
        if (error) {
            [self sendFailDelegateWithApiRequest:apiRequest andError:error];
        } else {
            ApiResponse *apiResponse = [ApiResponse responseWithDictionary:data error:&error];
            if (error) {
                [self sendFailDelegateWithApiRequest:apiRequest andError:error];
            } else {
                if ([apiResponse success]) {
                    [self sendRequest:apiRequest];
                }
            }
        }
    }];
}

- (void)sendRequest:(ApiRequest *)apiRequest {
    [self sendRequest:apiRequest withCompletion:^(id dictionary, NSError *error) {
        if (error) {
            [self sendFailDelegateWithApiRequest:apiRequest andError:error];
        } else {
            ApiResponse *apiResponse = [ApiResponse responseWithDictionary:dictionary error:&error];
            if (!error) {
                if ([self.delegate respondsToSelector:@selector(service:didFinishRequest:withResponse:)]) {
                    [self.delegate service:self didFinishRequest:apiRequest withResponse:apiResponse];
                }
            } else {
                [self sendFailDelegateWithApiRequest:apiRequest andError:error];
            }
        }
    }];
}

#pragma mark - Private Methods

/**
 * The function is a router juge by apiRequest.method
 **/
- (void)sendRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id dictionary, NSError *error))completion {
    if ([self.delegate respondsToSelector:@selector(service:willStartRequest:)]) {
        [self.delegate service:self willStartRequest:apiRequest];
    }
    switch (apiRequest.method) {
        case ApiRequestMethodGet:
            [self sendGetRequest:apiRequest withCompletion:completion];
            break;
        case ApiRequestMethodPost:
            [self sendPostRequest:apiRequest withCompletion:completion];
            break;
        case ApiRequestMethodMutipartPost:
            [self sendMutiPartRequest:apiRequest withCompletion:completion];
            break;
        case ApiRequestMethodDelete:
            [self sendDeleteRequest:apiRequest withCompletion:completion];
            break;
        case ApiRequestMethodPut:
            [self sendPutRequest:apiRequest withCompletion:completion];
            break;
        default:
            break;
    }
    
}

/**
 * The Function send a Get Requst
 * To use the function, Url should confirm when ApiRequst Object created
 **/
- (void)sendGetRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id data, NSError *error))completion {
    AFHTTPSessionManager *manager = [ApiService createDefaultRequestmanager];
    [manager GET:apiRequest.url parameters:apiRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         completion(nil, error);
    }];
}

/**
 * The Function send a Delete Requst
 * To use the function, Url should confirm when ApiRequst Object created
 **/
- (void)sendDeleteRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id data, NSError *error))completion {
    AFHTTPSessionManager *manager = [ApiService createDefaultRequestmanager];
    [manager DELETE:apiRequest.url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

/**
 * The Function send a Post Requst
 **/
- (void)sendPostRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id data, NSError *error))completion {
    AFHTTPSessionManager *manager = [ApiService createDefaultRequestmanager];
    [manager POST:apiRequest.url parameters:apiRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

/**
 * The Function send a Put Requst
 **/
- (void)sendPutRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id data, NSError *error))completion {
    AFHTTPSessionManager *manager = [ApiService createDefaultRequestmanager];
    [manager PUT:apiRequest.url parameters:apiRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

/**
 * The Function send a Mutipart Requst
 * It will auto juge path or filedata type by ApiRequst.files or paths and append those into formdata
 **/
- (void)sendMutiPartRequest:(ApiRequest *)apiRequest withCompletion:(void (^)(id data, NSError *error))completion {
    AFHTTPSessionManager *manager = [ApiService createDefaultRequestmanager];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:apiRequest.url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [ApiService appendFormDataWithApiRequest:apiRequest andFormData:formData];
    } error:nil];
    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(responseObject, error);
        }
    }];
    [uploadTask resume];
}

#pragma mark - PrivateTools

- (void)handleResponseObject:(id)responseObject withCompletion:(void (^)(id data, NSError *error))completion {
    NSError *error = nil;
    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
    completion(responseObject, error);
}

- (void)sendFailDelegateWithApiRequest:(ApiRequest *)apiRequest andError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(service:didFailRequest:withError:)]) {
        [self.delegate service:self didFailRequest:apiRequest withError:error];
    }
}

+ (void)appendFormDataWithApiRequest:(ApiRequest *)apiRequest andFormData:(id<AFMultipartFormData>) formData {
    for (int i = 0; i < apiRequest.files.count; i ++) {
        if ([[apiRequest.files objectAtIndex:i] isKindOfClass:[NSData class]]) {
            [formData appendPartWithFileData:[apiRequest.files objectAtIndex:i] name:[NSString stringWithFormat:@"%@%d", @"file_", i] fileName:[NSString stringWithFormat:@"%@%d", @"file_", i] mimeType:@"png"];
        } else if ([[apiRequest.files objectAtIndex:i] isKindOfClass:[NSString class]]) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:[apiRequest.files objectAtIndex:i]] name:[NSString stringWithFormat:@"%@%d", @"file_", i] fileName:[NSString stringWithFormat:@"%@%d", @"file_", i] mimeType:@"image/jpeg" error:nil];
        }
    }
}

+ (AFHTTPSessionManager *)createDefaultRequestmanager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    return manager;
}

@end
