//
//  Feed.h
//  JastorTest
//
//  Created by guoshencheng on 10/27/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import "Entity.h"

@interface Feed : JSONModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSArray<Entity, ConvertOnDemand> *entities;

@end
