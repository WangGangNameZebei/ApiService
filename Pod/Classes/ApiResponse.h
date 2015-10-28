//
//  ApiResponse.h
//  ArchitectureProject
//
//  Created by guoshencheng on 6/16/15.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

/**
 * This is the class which saves response returned from server
 *
 * When data returned by AFNetworking, we transform it into NSDictionary and Assign the NSDictionary into this class
 * This class also provide some function of checking response status
 * To explan the Response to DTO or Other data models, please new a category maybe called "ApiResponse+Explanation.h&m" and add some function like：
 - (DTO *)transformIntoDTO {
 some handler functions
 return some DTOs;
 }
 **/

#import "JSONModel.h"
#import "Feed.h"
#import "Entity.h"

@interface ApiResponse : JSONModel

@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *encoding;
@property (strong, nonatomic) NSString *errorCode;
@property (strong, nonatomic) NSString *errorMsg;
@property (strong, nonatomic) Feed *feed;
@property (strong, nonatomic) Entity *entity;

- (id)initWithDictionary:(NSDictionary*)d error:(NSError *__autoreleasing *)err;
- (BOOL)success;

@end
