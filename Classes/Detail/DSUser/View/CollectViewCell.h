//
//  CollectViewCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/10/6.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewCell.h"

@interface CollectViewCell : UICollectionViewCell

@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, weak) id<ShareViewCellDelegate> delegate;

@end
