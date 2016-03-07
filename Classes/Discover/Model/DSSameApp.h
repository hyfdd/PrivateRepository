//
//  DSSameApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"
#import "DSUser.h"

@protocol DSSameApp

@end

@interface DSSameApp : JSONModel

/// 用户/作者
@property (nonatomic, strong) DSUser *author;
/// 摘要
@property (copy, nonatomic) NSString *digest;
/// id
@property (assign, nonatomic) NSInteger tmd;
/// 类型
@property (copy, nonatomic) NSString *type;
/// 被顶次数
@property (assign, nonatomic) NSInteger upTimes;
/// 网址链接
@property (copy, nonatomic) NSString<Optional> *url;

@end
