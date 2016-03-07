//
//  DSSameApp.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSSameApp.h"

@implementation DSSameApp

+(JSONKeyMapper*)keyMapper
{
    [JSONModel setGlobalKeyMapper:[
                                   [JSONKeyMapper alloc] initWithDictionary:@{
                                                                              @"id":@"tmd",
                                                                              @"description": @"desc"
                                                                              }]
     ];
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
