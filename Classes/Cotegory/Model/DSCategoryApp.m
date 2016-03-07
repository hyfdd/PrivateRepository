//
//  DSCategoryApp.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCategoryApp.h"

@implementation DSCategoryApp

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)appWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (void)setValuesWithDictionary:(NSDictionary *)dictionary{
//    @property (copy, nonatomic) NSString *iconUrl;
//    @property (assign, nonatomic) NSInteger appid;
//    @property (assign, nonatomic) NSInteger isApp;
//    @property (copy, nonatomic) NSString *title;
//    @property (copy, nonatomic) NSString *subTitle;
//    @property (copy, nonatomic) NSString *type;
    self.iconUrl = dictionary[@"icon_url"];
    self.appid = dictionary[@"id"];
    self.isApp = dictionary[@"is_app"];
    self.title = dictionary[@"title"];
    self.subTitle = dictionary[@"sub_title"];
    self.type = dictionary[@"type"];
}

@end
