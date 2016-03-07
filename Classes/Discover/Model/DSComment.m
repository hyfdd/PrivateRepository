//
//  DSComment.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/23.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSComment.h"
#import "Helper.h"

@implementation DSComment

+(JSONKeyMapper*)keyMapper
{
    [JSONModel setGlobalKeyMapper:[
                                   [JSONKeyMapper alloc] initWithDictionary:@{
                                                                              @"description": @"desc"
                                                                              }]
     ];
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

- (NSNumber *)cellHeight{
    double height = [Helper heightOfString:_content font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH - 36]+ 106.0;
    return [NSNumber numberWithDouble:height];
}


@end
