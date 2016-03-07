//
//  ShareViewCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/10/6.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewCellDelegate <NSObject>

- (void)cellDidScrollUp:(UICollectionViewCell *)cell;
- (void)cellDidScrollDown:(UICollectionViewCell *)cell;

@end

@interface ShareViewCell : UICollectionViewCell

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, weak) id<ShareViewCellDelegate> delegate;

@end
