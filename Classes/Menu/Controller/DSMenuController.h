//
//  DSMenuController.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSDrawerController;

@protocol DSMenuControllerDelegate <NSObject>

@optional
- (void)pushViewControllerAtIndex:(NSInteger)index;

@end

@interface DSMenuController : UIViewController

@property (nonatomic, weak) id<DSMenuControllerDelegate> delegate;

@end
