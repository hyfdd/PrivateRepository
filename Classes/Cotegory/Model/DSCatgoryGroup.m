//
//  DSCatgoryGroup.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCatgoryGroup.h"
#import "DSCategoryApp.h"

@implementation DSCatgoryGroup

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        _apps = [NSArray array];
        [self setValuesWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (void)setValuesWithDictionary:(NSDictionary *)dictionary{
    self.iconUrl = dictionary[@"icon_url"];
    self.groupId = dictionary[@"id"];
    self.title = dictionary[@"title"];
    NSArray *topApps = dictionary[@"top_apps"];
    for (NSDictionary *dic in topApps) {
        DSCategoryApp *app = [DSCategoryApp appWithDictionary:dic];
        self.apps = [_apps arrayByAddingObject:app];
    }
}

@end
