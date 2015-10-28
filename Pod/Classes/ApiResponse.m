//
//  ApiResponse.m
//  ArchitectureProject
//
//  Created by guoshencheng on 6/16/15.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import "ApiResponse.h"

@implementation ApiResponse

- (id)initWithDictionary:(NSDictionary *)dictionary error:(NSError *__autoreleasing *)err {
    self = [super init];
    if (self) {
        self.version = dictionary[@"version"];
        self.encoding = dictionary[@"encoding"];
        self.errorCode = dictionary[@"errorCode"];
        self.errorMsg = dictionary[@"errorMsg"];
        err = nil;
        self.entity = [[Entity alloc] initWithDictionary:dictionary[@"entity"] error:err];
        self.feed = [[Feed alloc] initWithDictionary:dictionary[@"feed"] error:err];
    }
    return self;
}

- (BOOL)success {
    return [self.errorCode isEqualToString:@"200"];
}

@end
