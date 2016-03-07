//
//  DSDaylyApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/19.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"
#import "DSDaylyAppInfo.h"
#import "DSUser.h"
#import "DSSameApp.h"

@interface DSDaylyApp : JSONModel

/// 作者头像
@property (copy, nonatomic) NSString *authorAvatarUrl;
/// 作者详情背景颜色
@property (copy, nonatomic) NSString *authorBgcolor;
/// 作者类别
@property (copy, nonatomic) NSString *authorCareer;
/// 作者性别
@property (copy, nonatomic) NSString *authorGender;
/// 作者ID
@property (assign, nonatomic) NSInteger authorId;
/// 作者姓名
@property (copy, nonatomic) NSString *authorUsername;
/// 页面内容
@property (copy, nonatomic) NSString *content;
/// 页面高度
@property (assign, nonatomic) NSNumber<Optional> *contentHeight;
/// 封面图片
@property (copy, nonatomic) NSString *coverImage;
/// 创建时间
@property (copy, nonatomic) NSString *createTime;
/// 简述
@property (copy, nonatomic) NSString *digest;
/// 下载地址
@property (copy, nonatomic) NSString *downloadUrl;
/// 图标
@property (copy, nonatomic) NSString *iconImage;
/// id
@property (assign, nonatomic) NSInteger id;
/// info
@property (nonatomic, strong) DSDaylyAppInfo *info;
/// sameAPP
@property (nonatomic, strong) NSArray<DSSameApp> *sameApps;
/// QR二维码地址
@property (copy, nonatomic) NSString *qrcodeImage;
/// 大小
@property (copy, nonatomic) NSString *size;
/// 副标题
@property (copy, nonatomic) NSString *subTitle;
/// 标签
@property (copy, nonatomic) NSString *tags;
/// 标题
@property (copy, nonatomic) NSString *title;
/// 点赞用户详细信息(前20名)
@property (nonatomic, strong) NSArray<DSUser> *upUsers;

@end
