//
//  DSUser.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

// typedef NS_ENUM(NSInteger, Userdentity) <#new#>;

@protocol DSUser

@end

@interface DSUser : JSONModel

/// 头像URL
@property (copy, nonatomic) NSString *avatarUrl;
/// 个人详情背景颜色
@property (copy, nonatomic) NSString *bgColor;
/// 说说
@property (copy, nonatomic) NSString *career;
/// enname
@property (copy, nonatomic) NSString<Optional> *enname;
/// 花朵数量
@property (assign, nonatomic) NSInteger flowers;
/// 性别
@property (copy, nonatomic) NSString *gender;
/// 昵称
@property (copy, nonatomic) NSString<Optional> *name;
/// VIP标志
@property (assign, nonatomic) BOOL identity;
/// id
@property (strong, nonatomic) NSNumber<Optional> *tmd;


@end
