//
//  Entity.h
//  JastorTest
//
//  Created by guoshencheng on 10/27/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import "JSONModel.h"
@protocol Entity @end
@interface Entity : JSONModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSDictionary *model;

@end
