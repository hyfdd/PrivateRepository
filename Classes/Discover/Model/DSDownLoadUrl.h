//
//  DSDownLoadUrl.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

@protocol DSDownLoadUrl

@end

@interface DSDownLoadUrl : JSONModel

/// 下载渠道
@property (copy, nonatomic) NSString *channel;
/// 渠道名称
@property (copy, nonatomic) NSString *name;
/// 下载链接
@property (copy, nonatomic) NSString *url;

@end
