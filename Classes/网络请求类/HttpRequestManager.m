//
//  HttpRequestManager.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "HttpRequestManager.h"
#import "AFNetworking.h"
#import "Port.h"

@implementation HttpRequestManager

+ (instancetype)shareManger{
    static HttpRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpRequestManager alloc] init];
    });
    return manager;
}

- (void)getDaylyInfoWithPage:(NSInteger)page type:(DaylyAppType)type success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = nil;
    if (type == DaylyAppTypeNone) {
        urlString = [NSString stringWithFormat:DAYLY_BEST_URL, page];
    }else if (type == DaylyAppTypeGame) {
        urlString = [NSString stringWithFormat:GAME_URL, page];
    }
    // DSLog(@"UrlString = %@", urlString);
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        NSArray *apps = dic[@"apps"];
        success(apps);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getCategoryInfoSuccess:(httpSuccess)success failure:(httpFailure)failure{
    [[AFHTTPRequestOperationManager manager] GET:CATEGORY_STAR_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // DSLog(@"%@", responseObject);
         NSDictionary *dic = responseObject[@"data"];
         NSArray *apps = dic[@"apps"];
         success(apps);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getNewAppInfoWithPos:(NSInteger)pos success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:DISCOVER_NEW_URL, pos];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // DSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"data"];
        NSArray *apps = dic[@"apps"];
        success(apps);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getFriendRankInfoSuccess:(httpSuccess)success failure:(httpFailure)failure{
    [[AFHTTPRequestOperationManager manager] GET:DISCOVER_FRIEND_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DSLog(@"%@", DISCOVER_FRIEND_URL);
        NSDictionary *dic = responseObject[@"data"];
        NSArray *userRank = dic[@"users_rank"];
        success(userRank);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getCommentInfoWithId:(NSInteger)commentID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:COMMENT_URL, commentID, page];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // DSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getAppInfoWithId:(NSInteger)appID success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:APP_INFO_URL, appID];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // DSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getMoreAppInfoWithId:(NSNumber *)groupID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:MORE_APP_URL, groupID, page];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"data"];
        NSArray *array = dic[@"apps"];
        success(array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

/// 根据用户id获取用户
- (void)getUserInfoWithId:(NSNumber *)userID success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:USER_INFO_URL, userID];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

/// 根据用户id和页数获取用户推荐APP信息
- (void)getUserCommunityAppInfoWithId:(NSNumber *)userID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:COMMUNITY_APPS_URL, userID, page];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

/// 根据用户ID和页数获取用户收藏APP信息
- (void)getUserCollectAppInfoWithId:(NSNumber *)userID page:(NSInteger)page success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:COLLECT_APPS_URL, userID, page];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getsearchInfoWithType:(NSString *)type success:(httpSuccess)success failure:(httpFailure)failure{
    NSString *urlString = [NSString stringWithFormat:SEARCH_INFO_URL, type];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        NSArray *array = dic[@"tags"];
        success(array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getsearchResultWithKeyword:(NSString *)keyword success:(httpSuccess)success failure:(httpFailure)failure{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:keyword forKey:@"keyword"];
    [dic setValue:@"platform" forKey:@"2"];
    [[AFHTTPRequestOperationManager manager] POST:SEARCH_RESULT_URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"searchResult-responseObject = %@", responseObject);
        NSDictionary *dic = responseObject[@"data"];
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
