//
//  DSDaylyController.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestManager.h"

@class DSDrawerController;

@interface DSDaylyController : UIViewController

#define Space 10.0;

@property (nonatomic, weak) DSDrawerController *drawerVC;
@property (nonatomic, assign) DaylyAppType type;

@end
