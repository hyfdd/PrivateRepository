//
//  DSFriendCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/18.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSFriendCellDelegate <NSObject>

- (void)pushViewController:(UIViewController *)viewController;

@end

@interface DSFriendCell : UICollectionViewCell

@property (nonatomic, weak) id<DSFriendCellDelegate> delegate;

@end
