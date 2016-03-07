//
//  DSTag.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"

@protocol DSTag

@end

@interface DSTag : JSONModel

@property (assign, nonatomic) NSInteger tmd;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *type;

@end
