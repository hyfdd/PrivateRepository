//
//  DSCatgoryGroup.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSCategoryApp.h"

@interface DSCatgoryGroup : NSObject

@property (copy, nonatomic) NSString *iconUrl;
@property (strong, nonatomic) NSNumber *groupId;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray<DSCategoryApp> *apps;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary;

- (void)setValuesWithDictionary:(NSDictionary *)dictionary;

@end
