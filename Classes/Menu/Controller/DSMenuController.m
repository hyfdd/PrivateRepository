//
//  DSMenuController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSMenuController.h"
#import "DSSearchController.h"

@interface DSMenuController ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadView;

@property (weak, nonatomic) IBOutlet UIView *sidebarView;
- (IBAction)clickSideBarButton:(UIButton *)sender;

@end

@implementation DSMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

- (void)setSubViews{
    [self clickSideBarButton:(UIButton *)[_sidebarView viewWithTag:101]];
    _userHeadView.layer.cornerRadius = 33;
    _userHeadView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 按钮点击事件

- (IBAction)clickSideBarButton:(UIButton *)sender{
    for (UIView *view in _sidebarView.subviews) {
        UIView *dot = [view viewWithTag:7];
        dot.hidden = YES;
    }
    [sender.superview viewWithTag:7].hidden = NO;
    
    if ([self.delegate respondsToSelector:@selector(pushViewControllerAtIndex:)]) {
        
        [_delegate pushViewControllerAtIndex:(sender.tag - 100)];
    }
}

- (IBAction)secrch:(id)sender {
    DSSearchController *searchVC = [[DSSearchController alloc] initWithNibName:@"DSSearchController" bundle:nil];
    searchVC.view.backgroundColor = self.view.backgroundColor;
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (IBAction)getFlowerInfo:(id)sender {
}

- (IBAction)showMore:(id)sender {
}

@end
