//
//  DSCategoryApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSCategoryApp

@end

@interface DSCategoryApp : NSObject

@property (copy, nonatomic) NSString *iconUrl;
@property (strong, nonatomic) NSNumber *appid;
@property (strong, nonatomic) NSNumber *isApp;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *type;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)appWithDictionary:(NSDictionary *)dictionary;

- (void)setValuesWithDictionary:(NSDictionary *)dictionary;

@end
