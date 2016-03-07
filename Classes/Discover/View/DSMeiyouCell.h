//
//  DSMeiyouCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSUser;

@interface DSMeiyouCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (assign, nonatomic, getter=isLast) BOOL last;
@property (nonatomic, strong) DSUser *user;

@end
