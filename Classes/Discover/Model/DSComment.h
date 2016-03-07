//
//  DSComment.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/23.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"
#import "DSUser.h"

@interface DSComment : JSONModel

/// 评论用户
@property (nonatomic, strong) DSUser *author;
/// 评论内容
@property (copy, nonatomic) NSString *content;
/// 创建时间
@property (copy, nonatomic) NSString *createdAt;
/// 下载次数
@property (assign, nonatomic) NSInteger downTimes;
/// 热门回复
@property (strong, nonatomic) NSArray *hotReplys;
/// id
@property (assign, nonatomic) NSInteger id;
/// 回复次数
@property (assign, nonatomic) NSInteger replyTimes;
/// 类型
@property (copy, nonatomic) NSString *type;
/// 置顶次数
@property (assign, nonatomic) NSInteger upTimes;

/// 所在cell高度
@property (assign, nonatomic) NSNumber<Optional> *cellHeight;

@end
