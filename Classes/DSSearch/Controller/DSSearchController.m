//
//  DSSearchController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/9.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSSearchController.h"
#import "DSTagCell.h"
#import "HttpRequestManager.h"
#import "DSTag.h"
#import "UILabel+Alert.h"
#import "Helper.h"
#import "DSCategoryApp.h"
#import "DSCategoryCell.h"
#import "DSCategoryHeadView.h"
#import "DSCategoryFootView.h"

@interface DSSearchController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DSCategoryHeadViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *seachTextField;

@end

@implementation DSSearchController
{
    NSMutableArray *_tableDataArray;
    NSMutableArray *_collectDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

- (void)setSubViews{
    _tableDataArray = [NSMutableArray array];
    _collectDataArray = [NSMutableArray array];
    [_seachTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _tableView.hidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DSCategoryCell" bundle:nil] forCellReuseIdentifier:@"DSCategoryCell"];
    
    NSLog(@"collectionView:%@",_collectionView);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DSTagCell class] forCellWithReuseIdentifier:@"DSTagCell"];
    [self loadSearchDataFromNet];
}

- (void)loadSearchDataFromNet{
    [[HttpRequestManager shareManger]getsearchInfoWithType:@"zuimei.tag.home" success:^(id responseObject) {
        NSArray *array = responseObject;
        for (NSDictionary *dic in array) {
            DSTag *model = [[DSTag alloc] initWithDictionary:dic error:nil];
            if (model) {
                [_collectDataArray addObject:model];
            }
        }
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"请求数据失败"];
        [label showInView:self.view];
    }];
    
}

#pragma mark - UItableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _tableDataArray[section];
    return array.count > 5 ? 5 : array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = _tableDataArray[indexPath.section];
    DSCategoryApp *app = array[indexPath.row];
    DSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSCategoryCell"];
    cell.app = app;
    if (indexPath.row == 4) {
        [cell hideSeparator:YES];
    }else {
        [cell hideSeparator:NO];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{\
    DSCategoryHeadView *view = [[NSBundle mainBundle] loadNibNamed:@"DSCategoryHeadView" owner:self options:0][0];
    view.delegate = self;
    return view;
}

- (void)showMore:(UIViewController *)moreVC{
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *array = _tableDataArray[section];
    NSLog(@"%ld", array.count);
    if (array.count > 0) {
        return 64.0;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DSCategoryFootView *view = [[NSBundle mainBundle] loadNibNamed:@"DSCategoryFootView" owner:self options:0][0];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSArray *array = _tableDataArray[section];
    if (array.count > 0) {
        return 15.0;
    }
    return 0.0;
}



#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _collectDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DSTagCell" forIndexPath:indexPath];
    DSTag *model = _collectDataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSTag *model = _collectDataArray[indexPath.row];
    CGFloat width = [Helper widthOfString:model.title font:[UIFont systemFontOfSize:14] height:30];
    return CGSizeMake(width + 40, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DSTag *model = _collectDataArray[indexPath.row];
    _seachTextField.text = model.title;
    [self search];
}
#pragma mark - 按钮点击事件
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)search {
    if (_seachTextField.text.length == 0) {
        return;
    }
    NSString *keyword = _seachTextField.text;
    [[HttpRequestManager shareManger]getsearchResultWithKeyword:keyword success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *apps = dic[@"apps"];
        NSArray *articles = dic[@"articles"];
        NSMutableArray *arr1 = [NSMutableArray array];
        for (NSDictionary *dict in articles) {
            DSCategoryApp *app = [[DSCategoryApp alloc] initWithDictionary:dict];
            if (app) {
                [arr1 addObject:app];
            }
        }
        if (arr1.count > 0) {
            [_tableDataArray addObject:arr1];
        }
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dict in apps) {
            DSCategoryApp *app = [[DSCategoryApp alloc] initWithDictionary:dict];
            if (app) {
                [arr2 addObject:app];
            }
        }
        if (arr2.count > 0) {
            [_tableDataArray addObject:arr2];
        }
        _collectionView.hidden = YES;
        _tableView.hidden = NO;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



@end
