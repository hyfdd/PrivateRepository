//
//  DSJumpController.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/28.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSJumpControllerDelegate <NSObject>

- (void)jumpControllerDidSelectedItemAtIndex:(NSInteger)index;

@end

@interface DSJumpController : UIViewController

@property (nonatomic, strong) NSArray *apps;

@property (assign, nonatomic) NSInteger iconNumber;

@property (assign, nonatomic) CGFloat space;

@property (weak, nonatomic) id<DSJumpControllerDelegate> delegate;

- (void)selectItemAtIndex:(NSInteger)index;

- (void)selectedNextItem;

- (void)selectedpreviousItem;

@end
