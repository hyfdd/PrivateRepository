//
//  DSDrawerController.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSMenuController.h"

@interface DSDrawerController : UIViewController <DSMenuControllerDelegate>

/**
 *  主视图
 */
@property (nonatomic, strong) UINavigationController *mainVC;
/**
 *  左侧菜单视图
 */
@property (nonatomic, strong) UIViewController *menuVC;
/**
 *  左侧菜单视图显示宽度
 */
@property (nonatomic, assign) CGFloat menuViewWidth;

- (instancetype)initWithMainViewController:(UINavigationController *)mainVC menuViewController:(UIViewController *)menuVC menuViewWidth:(CGFloat)width;

- (void)showMainViewController;

- (void)showMenuViewController;

@end
