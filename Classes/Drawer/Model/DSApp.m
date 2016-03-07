//
//  DSApp.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSApp.h"

@implementation DSApp

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValuesWithDictionary:(NSDictionary *)dict{
    _coverImage = dict[@"cover_image"];
    _createTime = dict[@"create_time"];
    _digest = dict[@"digest"];
    _appID = dict[@"id"];
    _title = dict[@"title"];
    _subTitel = dict[@"sub_title"];
    _iconImage = dict[@"icon_image"];
}

@end
