//
//  HttpRequestManager.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DaylyAppType) {
    DaylyAppTypeNone = 0,  // 默认为每日最美软件
    DaylyAppTypeGame       // 游戏
};

/**
 * 成功回调
 */
typedef void (^httpSuccess)(id responseObject);
/**
 * 失败回调
 */
typedef void (^httpFailure)(NSError *error);

@interface HttpRequestManager : NSObject

+ (instancetype)shareManger;

/**
 *  用于获取每日最美推荐软甲信息
 *  page,页数
 *  type,应用类型
 */
- (void)getDaylyInfoWithPage:(NSInteger)page type:(DaylyAppType)type success:(httpSuccess)success failure:(httpFailure)failure;

/**
 *  用于获取分类软件信息
 */
- (void)getCategoryInfoSuccess:(httpSuccess)success failure:(httpFailure)failure;

/// 获取发现应用--最新信息
- (void)getNewAppInfoWithPos:(NSInteger)pos success:(httpSuccess)success failure:(httpFailure)failure;

/// 获取美友排行信息
- (void)getFriendRankInfoSuccess:(httpSuccess)success failure:(httpFailure)failure;


/// 获取评论内容
- (void)getCommentInfoWithId:(NSInteger)commentID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据appid获取App信息
- (void)getAppInfoWithId:(NSInteger)appID success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据分组id获取更多App信息
- (void)getMoreAppInfoWithId:(NSNumber *)groupID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据用户id获取用户
- (void)getUserInfoWithId:(NSNumber *)userID success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据用户id和页数获取用户推荐APP信息
- (void)getUserCommunityAppInfoWithId:(NSNumber *)userID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据用户ID和页数获取用户收藏APP信息
- (void)getUserCollectAppInfoWithId:(NSNumber *)userID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据搜索类型获取搜索信息
- (void)getsearchInfoWithType:(NSString *)type success:(httpSuccess)success failure:(httpFailure)failure;

/// 根据搜索类型获取搜索信息
- (void)getsearchResultWithKeyword:(NSString *)keyword success:(httpSuccess)success failure:(httpFailure)failure;

@end
