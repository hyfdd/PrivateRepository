//
//  DSDaylyAppInfo.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/19.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDaylyAppInfo.h"

@implementation DSDaylyAppInfo

+(JSONKeyMapper*)keyMapper
{
    [JSONModel setGlobalKeyMapper:[
                                   [JSONKeyMapper alloc] initWithDictionary:@{
                                                                              @"description": @"desc"
                                                                              }]
     ];
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
