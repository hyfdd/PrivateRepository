//
//  DSApp.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSApp : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitel;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, assign) NSNumber *appID;
@property (nonatomic, copy) NSString *upNumber;
@property (nonatomic, copy) NSString *iconImage;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)appWithDictionary:(NSDictionary *)dict;
- (void)setValuesWithDictionary:(NSDictionary *)dict;

@end
