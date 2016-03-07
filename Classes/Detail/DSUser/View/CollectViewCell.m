//
//  CollectViewCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/6.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "CollectViewCell.h"
#import "HttpRequestManager.h"
#import "DSCollectApp.h"
#import "UILabel+Alert.h"
#import "UIImageView+AFNetworking.h"
#import "CollectAppCell.h"
#import "CollectFootView.h"

@interface CollectViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CollectViewCell
{
    NSMutableArray *_dataArray;
    NSInteger _currentPage;
    BOOL _hasNext;
    BOOL _refreshing;
}

- (void)awakeFromNib {
    // Initialization code
    [self setSubViews];
}

- (void)setSubViews{
    _dataArray = [NSMutableArray array];
    _currentPage = 1;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectAppCell" bundle:nil] forCellWithReuseIdentifier:@"CollectAppCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectFootView"];
}

- (void)setUserID:(NSNumber *)userID{
    _userID = userID;
    [self loadDataFromNet];
}

- (void)loadDataFromNet{
    [[HttpRequestManager shareManger]getUserCollectAppInfoWithId:_userID page:_currentPage success:^(id responseObject) {
        if (_currentPage == 1) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"collections"];
        NSNumber *number = dic[@"has_next"];
        _hasNext = number.boolValue;
        NSError *error = nil;
        for (NSDictionary *dic in array) {
            DSCollectApp *app = [[DSCollectApp alloc]initWithDictionary:dic error:&error];
            if (app) {
                [_dataArray addObject:app];
            }
        }
        _refreshing = NO;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        UILabel *alert = [[UILabel alloc] initWithMessage:@"获取个人收藏应用信息失败"];
        [alert showInView:self];
    }];
}

#pragma mark - UICOllectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectAppCell" forIndexPath:indexPath];
    cell.app = _dataArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH * 0.5 - 22.5, 157);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_refreshing) {
        return CGSizeMake(0, 50);
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        CollectFootView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectFootView" forIndexPath:indexPath];
        view = footer;
    }
    return view;
}

#pragma mark - UIScrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0) {
        if ([_delegate respondsToSelector:@selector(cellDidScrollDown:)]) {
            [_delegate cellDidScrollUp:nil];
        }
    }else {
        if ([_delegate respondsToSelector:@selector(cellDidScrollUp:)]) {
            [_delegate cellDidScrollDown:nil];
        }
    }
    if (!_hasNext) {
        return;
    }
    if (scrollView.contentOffset.y > scrollView.contentSize.height - self.bounds.size.height + 44 && _refreshing == NO) {
        _currentPage ++;
        _refreshing = YES;
        [self.collectionView reloadData];
        [self loadDataFromNet];
    }
}

@end
