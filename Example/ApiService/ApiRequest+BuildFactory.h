//
//  ApiRequest+BuildFactory.h
//  ApiService
//
//  Created by guoshencheng on 10/10/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import <ApiService/ApiService.h>

@interface ApiRequest (BuildFactory)

+ (instancetype)requestForGet;
+ (instancetype)requestForPost;
+ (instancetype)requestForDelete;
+ (instancetype)requestForPut;
+ (instancetype)requestForMultiparty;

@end
