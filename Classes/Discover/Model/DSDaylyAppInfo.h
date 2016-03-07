//
//  DSDaylyAppInfo.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/19.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

@protocol DSDaylyAppInfo

@end

@interface DSDaylyAppInfo : JSONModel

/// av
@property (copy, nonatomic) NSString *av;
/// 下载次数
@property (copy, nonatomic) NSString *down;
/// 所有下载用户ID
@property (nonatomic, strong) NSArray *downUsers;
/// 喜爱用户数量
@property (copy, nonatomic) NSString *fav;
/// 所有喜爱用户ID
@property (nonatomic, strong) NSArray *favUsers;
/// 点赞用户数量
@property (copy, nonatomic) NSString *up;
/// 所有点赞用户
@property (nonatomic, strong) NSArray *upUsers;

@end
