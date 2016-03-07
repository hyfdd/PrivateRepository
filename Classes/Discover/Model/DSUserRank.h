//
//  DSUserRank.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/18.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "JSONModel.h"
#import "DSUser.h"

@interface DSUserRank : JSONModel

@property (copy, nonatomic) NSString *iconImage;

@property (copy, nonatomic) NSString *name;

@property (nonatomic, strong) NSArray<DSUser> *users;

@end
