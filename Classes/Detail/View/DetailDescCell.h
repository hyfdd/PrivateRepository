//
//  DetailDescCell.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/21.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSDaylyApp;

@interface DetailDescCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@property (nonatomic, strong) DSDaylyApp *app;

+ (CGFloat)heightWithApp:(DSDaylyApp *)app;

@end
