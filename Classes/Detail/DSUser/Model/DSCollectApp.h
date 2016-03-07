//
//  DSCollectApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/10/8.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

@interface DSCollectApp : JSONModel

/// 评论次数
@property (nonatomic, strong) NSNumber *commentTimes;
/// 下载次数
@property (nonatomic, strong) NSNumber *downTimes;
/// icon
@property (copy, nonatomic) NSString *icon;
/// id
@property (nonatomic, strong) NSNumber *tmd;
/// 源
@property (copy, nonatomic) NSString *source;
/// 源信息
@property (copy, nonatomic) NSString *sourceMsg;
/// 标题
@property (copy, nonatomic) NSString *title;
/// 点赞次数
@property (nonatomic, strong) NSNumber *upTimes;


@end
