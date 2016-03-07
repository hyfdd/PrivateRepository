//
//  DiscoverCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DiscoverCellType) {
    /// 精选
    DiscoverCellTypeBest = 0,
    /// 最新
    DiscoverCellTypeNew = 1,
    /// 美友
    DiscoverCellTypeMeiyou = 3,
    /// 排行
    DiscoverCellTypeRank = 4
};

@interface DiscoverCell : UICollectionViewCell

@property (assign, nonatomic) DiscoverCellType disCovertype;

@end
