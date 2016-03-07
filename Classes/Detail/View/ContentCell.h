//
//  ContentCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/20.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property (copy, nonatomic) NSString *content;

- (void)setContent:(NSString *)content;

@end
