//
//  DSDaylyController.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/16.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestManager.h"

@class DSDrawerController;

@interface DSDaylyController : UIViewController

@property (nonatomic, assign) DaylyAppType type;
@property (nonatomic, weak) DSDrawerController *drawerVC;


+ (instancetype)defaultController;

@end
