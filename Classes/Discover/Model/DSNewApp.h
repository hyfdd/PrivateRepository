//
//  DSNewApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"
#import "DSUser.h"
#import "DSSameApp.h"
#import "DSDownLoadUrl.h"
#import "DSTag.h"

@protocol DSNewApp

@end

@interface DSNewApp : JSONModel

/// 所有图片
@property (nonatomic, strong) NSArray *allImages;
/// 作者头像URL
@property (copy, nonatomic) NSString *authorAvatarUrl;
/// 作者详情的背景颜色
@property (copy, nonatomic) NSString *authorBgcolor;
/// 作者个性签名
@property (copy, nonatomic) NSString *authorCareer;
/// 作者花朵数量
@property (assign, nonatomic) NSInteger authorFlowers;
/// 作者性别
@property (copy, nonatomic) NSString *authorGender;
/// 作者ID
@property (assign, nonatomic) NSInteger authorId;
/// 作者昵称
@property (copy, nonatomic) NSString *authorName;
/// canShow
@property (assign, nonatomic) BOOL canShow;
/// 收藏次数
@property (assign, nonatomic) NSInteger collectTimes;
/// 收藏用户数组
@property (nonatomic, strong) NSArray<DSUser> *collectUsers;
/// 评论次数
@property (assign, nonatomic) NSInteger commentTimes;
/// 评论数组
// @property (nonatomic, strong) NSArray *comments;
/// 封面图片URL
@property (copy, nonatomic) NSString *coverImage;
/// 创建时间
@property (copy, nonatomic) NSString *createdAt;
/// 描述
@property (copy, nonatomic) NSString *desc;
/// 下载次数
@property (assign, nonatomic) NSInteger downTimes;
/// 下载用户数组
@property (nonatomic, strong) NSArray<DSUser> *downUsers;
/// 下载地址
@property (nonatomic, strong) NSArray<DSDownLoadUrl> *downloadUrls;
/// 应用图标
@property (copy, nonatomic) NSString *iconImage;
/// 应用ID
@property (assign, nonatomic) NSNumber<Optional> *appID;
/// 下一组数据接口
@property (assign, nonatomic) NSInteger pos;
/// 相同推荐(可通过此跳转)
@property (nonatomic, strong) NSArray<DSSameApp> *sameApps;
/// SHOW次数
@property (assign, nonatomic) NSInteger showTimes;
/// 软件包大小
@property (copy, nonatomic) NSString *size;
/// 标签数组
@property (nonatomic, strong) NSArray<DSTag> *tags;
/// 副标题
@property (copy, nonatomic) NSString *subTitle;
/// 主标题
@property (copy, nonatomic) NSString *title;
/// 点赞次数
@property (assign, nonatomic) NSInteger upTimes;
/// 点赞用户
@property (nonatomic, strong) NSArray<DSUser> *upUsers;
/// update
@property (copy, nonatomic) NSString *updatedAt;



@end
