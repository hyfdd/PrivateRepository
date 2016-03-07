//
//  DSCategoryHeadView.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol DSCategoryHeadViewDelegate <NSObject>

@required
- (void)showMore:(UIViewController *)moreVC;

@end

@class DSCatgoryGroup;

@interface DSCategoryHeadView : UIView

@property (strong, nonatomic) DSCatgoryGroup *group;

@property (nonatomic, weak) id<DSCategoryHeadViewDelegate> delegate;

@end
