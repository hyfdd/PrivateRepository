//
//  DSDiscoverController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDiscoverController.h"
#import "DSDrawerController.h"
#import "DiscoverCell.h"
#import "DSNewCell.h"
#import "DSFriendCell.h"
#import "HttpRequestManager.h"

@interface DSDiscoverController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DSFriendCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *discoverCollectionView;

@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UIImageView *boardView;

- (IBAction)showMenuController;
- (IBAction)search;
- (IBAction)choiceCategory:(UIButton *)button;

@end

@implementation DSDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDiscoverCollectionView];
}

- (void)setDiscoverCollectionView{
    self.discoverCollectionView.delegate = self;
    self.discoverCollectionView.dataSource = self;
    [self.discoverCollectionView registerNib:[UINib nibWithNibName:@"DiscoverCell" bundle:nil] forCellWithReuseIdentifier:@"DiscoverCell"];
    [self.discoverCollectionView registerNib:[UINib nibWithNibName:@"DSNewCell" bundle:nil] forCellWithReuseIdentifier:@"DSNewCell"];
    [self.discoverCollectionView registerNib:[UINib nibWithNibName:@"DSFriendCell" bundle:nil] forCellWithReuseIdentifier:@"DSFriendCell"];
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
#pragma mark - UICOllectionView代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            DSNewCell *cell = [_discoverCollectionView dequeueReusableCellWithReuseIdentifier:@"DSNewCell" forIndexPath:indexPath];
            return cell;
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            DSFriendCell *cell = [_discoverCollectionView dequeueReusableCellWithReuseIdentifier:@"DSFriendCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            break;
        }
        case 4:
        {
            break;
        }
            
        default:
            break;
    }
    DiscoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverCell" forIndexPath:indexPath];
    cell.backgroundColor = RandomRGBColor;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.discoverCollectionView.bounds.size;
    
}

#pragma mark - UIScrollView代理方法

// 重新记录当前collectionView偏移量;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = point.x / SCREEN_WIDTH;
    UIButton *button = (UIButton *)[_categoryView viewWithTag:(100 + index)];
    [self choiceCategory:button];
}

#pragma mark - DSFriendCell代理方法
- (void)pushViewController:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 按钮点击事件
- (IBAction)showMenuController {
    [self.drawerVC showMenuViewController];
}

- (IBAction)search {
    
}

- (IBAction)choiceCategory:(UIButton *)button{
    CGPoint center = _boardView.center;
    CGFloat tx = 0.0;
    if (center.x == button.center.x) {
        return;
    }else {
        tx = button.center.x > center.x ? 5 : -5;
    }
    center.x = button.center.x + tx;
    [UIView animateWithDuration:0.2 animations:^{
        _boardView.center = center;
    }completion:^(BOOL finished) {
        CGPoint newCenter = _boardView.center;
        newCenter.x = newCenter.x - tx;
        [UIView animateWithDuration:0.1 animations:^{
            _boardView.center = newCenter;
        }];
    }];
    NSInteger index = button.tag - 100;
    [_discoverCollectionView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}

@end
