//
//  DSAuthor.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/19.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

@protocol DSAuthor

@end

@interface DSAuthor : JSONModel

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


@end
