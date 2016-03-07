//
//  DSDrawerController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDrawerController.h"
#import "DSDaylyController.h"
#import "DSDiscoverController.h"
#import "DSCategoryController.h"
#import "DSGameController.h"

@interface DSDrawerController ()
{
    UIView *_coverView;
}

@end

@implementation DSDrawerController

- (instancetype)initWithMainViewController:(UINavigationController *)mainVC menuViewController:(UIViewController *)menuVC menuViewWidth:(CGFloat)width{
    if (self = [super init]) {
        self.mainVC = mainVC;
        self.menuVC = menuVC;
        self.menuViewWidth = width;
        
        // 给抽屉视图控制器添加子视图控制器
        [self addChildViewController:mainVC];
        [self addChildViewController:menuVC];
        
        // 将子视图控制器的View 添加到自身View之上
        [self.view addSubview:mainVC.view];
        [self.view addSubview:menuVC.view];
        
        // 设置初始位置
        mainVC.view.frame = CGRectMake(width, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        menuVC.view.frame = CGRectMake(0, 0, width, SCREEN_HEIGHT);
        [self.view bringSubviewToFront:mainVC.view];
        
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainViewController)];
        [_coverView addGestureRecognizer:tap];
        [mainVC.view addSubview:_coverView];
        
         self.view.backgroundColor = self.mainVC.view.backgroundColor;
         self.menuVC.view.backgroundColor = self.view.backgroundColor;
    }
    return self;
}

- (void)changeMainVC:(UINavigationController *)mainVC{
    mainVC.view.backgroundColor = self.view.backgroundColor;
    [_mainVC.view removeFromSuperview];
    _mainVC = mainVC;
    // 给抽屉视图控制器添加子视图控制器
    [self addChildViewController:mainVC];
    
    // 将子视图控制器的View 添加到自身View之上
    [self.view addSubview:mainVC.view];
    
    // 设置初始位置
    mainVC.view.frame = CGRectMake(_menuViewWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view bringSubviewToFront:mainVC.view];
    
    [mainVC.view addSubview:_coverView];
    [self showMainViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - 显示菜单视图或者显示主视图方法
- (void)showMainViewController{
    [_coverView removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        _mainVC.view.frame = CGRectMake(-20, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        // _menuVC.view.frame = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, _menuViewWidth/2, SCREEN_HEIGHT/2);
        _menuVC.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _mainVC.view.frame = self.view.bounds;
        }];
    }];
}

- (void)showMenuViewController{
    [self.mainVC.view addSubview:_coverView];
    
    self.view.backgroundColor = _mainVC.topViewController.view.backgroundColor;
    self.menuVC.view.backgroundColor = self.view.backgroundColor;
    [UIView animateWithDuration:0.5 animations:^{
        _mainVC.view.frame = CGRectMake(_menuViewWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        // _menuVC.view.frame = CGRectMake(0, 0, _menuViewWidth, SCREEN_HEIGHT);
        _menuVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        _menuVC.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - DSMenuController代理方法
- (void)pushViewControllerAtIndex:(NSInteger)index{
    NSLog(@"%ld", index);
    switch (index) {
        case 0:
        {
            DSDiscoverController *discoverVC = [[DSDiscoverController alloc] initWithNibName:@"DSDiscoverController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:discoverVC];
            nav.navigationBarHidden = YES;
            discoverVC.view.backgroundColor = self.view.backgroundColor;
            discoverVC.drawerVC = self;
            [self changeMainVC:nav];
            break;
        }
        case 1:
        {
            DSDaylyController *daylyVC = [DSDaylyController defaultController];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:daylyVC];
            nav.navigationBarHidden = YES;
            daylyVC.view.backgroundColor = self.view.backgroundColor;
            daylyVC.drawerVC = self;
            daylyVC.type = DaylyAppTypeNone;
            [self changeMainVC:nav];
            break;
        }
        case 2:
        {
            DSCategoryController *categoryVC = [[DSCategoryController alloc] initWithNibName:@"DSCategoryController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:categoryVC];
            nav.navigationBarHidden = YES;
            categoryVC.view.backgroundColor = self.view.backgroundColor;
            categoryVC.drawerVC = self;
            [self changeMainVC:nav];
            break;
        }
        case 3:
        {
            DSDaylyController *gameVC = [DSDaylyController defaultController];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gameVC];
            nav.navigationBarHidden = YES;
            gameVC.view.backgroundColor = self.view.backgroundColor;
            gameVC.drawerVC = self;
            gameVC.type = DaylyAppTypeGame;
            [self changeMainVC:nav];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 收到内存警告调用方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
