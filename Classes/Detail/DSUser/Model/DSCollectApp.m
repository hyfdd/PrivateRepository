//
//  DSCollectApp.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/8.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSCollectApp.h"

@implementation DSCollectApp

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
