//
//  DSUserController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/6.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSUserController.h"
#import "ShareViewCell.h"
#import "CollectViewCell.h"
#import "Helper.h"
#import "UIImageView+AFNetworking.h"
#import "HttpRequestManager.h"
#import "UILabel+Alert.h"

@interface DSUserController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShareViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UIView *sliderView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;

@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *collectView;
@property (weak, nonatomic) IBOutlet UIView *userBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBackButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toViewBottom;

@property (strong, nonatomic) NSNumber *upCounts;

@property (assign, nonatomic) BOOL hideUserInfo;

@end

@implementation DSUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSubViews];
}

- (void)setUser:(DSUser *)user{
    _user = user;
    self.view.backgroundColor = [Helper getColor:user.bgColor];
    _userBgView.backgroundColor = self.view.backgroundColor;
    [_headImageView setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    _nameLabel.text = user.name;
    _detailLabel.text = user.career;
    
    [self loadUserAppInfo];
    DSLog(@"%@",_user.tmd);
}

- (void)setSubViews{
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;
    _headImageView.clipsToBounds = YES;
    
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH *0.5 - 10, 4)];
    _sliderView.backgroundColor = [UIColor whiteColor];
    [_detailView addSubview:_sliderView];
    
    UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShare)];
    [_shareView addGestureRecognizer:tapShare];
    
    UITapGestureRecognizer *tapCollection = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollection)];
    [_collectView addGestureRecognizer:tapCollection];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"ShareViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShareViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectViewCell"];
    [self.view sendSubviewToBack:_collectionView];
}

- (void)loadUserAppInfo{
    [[HttpRequestManager shareManger]getUserInfoWithId:_user.tmd success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        _shareLabel.text = [NSString stringWithFormat:@"%@", dic[@"app_counts"]];
        _collectLabel.text = [NSString stringWithFormat:@"%@", dic[@"collect_counts"]];;
        _upCounts = dic[@"up_counts"];
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取用户数据失败"];
        [label showInView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapShare{
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.transform = CGAffineTransformMakeTranslation(-10, 0);
        CGPoint point = _collectionView.contentOffset;
        point.x = 0;
        _collectionView.contentOffset = point;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _sliderView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }];
}

- (void)tapCollection{
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH * 0.5, 0);
        CGPoint point = _collectionView.contentOffset;
        point.x = SCREEN_WIDTH;
        _collectionView.contentOffset = point;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _sliderView.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH * 0.5 - 8, 0);
        }];
    }];
}

- (void)hideUserInfo:(BOOL)hidden{
    if (_hideUserInfo == hidden) {
        return;
    }
    _hideUserInfo = hidden;
    if (hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            _userView.transform = CGAffineTransformMakeTranslation(0, -148);
            _detailView.transform = CGAffineTransformMake(0.65, 0, 0, 0.65, 0, -128);
            _userBgView.transform = CGAffineTransformMakeTranslation(0, -128);
            _toBackButton.constant = 78;
            _toViewBottom.constant = 0;
        }completion:^(BOOL finished) {
            [self.collectionView reloadInputViews];
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            _userView.transform = CGAffineTransformMakeTranslation(0, 0);
            _detailView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            _userBgView.transform = CGAffineTransformMakeTranslation(0, 0);
            _toBackButton.constant = 212;
            _toViewBottom.constant = -134;
        }completion:^(BOOL finished) {
            [self.collectionView reloadInputViews];
        }];
    }
    
}

#pragma mark - cell代理方法
- (void)cellDidScrollUp:(UICollectionViewCell *)cell{
    [self hideUserInfo:YES];
}

- (void)cellDidScrollDown:(UICollectionViewCell *)cell{
    [self hideUserInfo:NO];
}

#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareViewCell" forIndexPath:indexPath];
        cell.userId = _user.tmd;
        cell.delegate = self;
        return cell;
    }else {
        CollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectViewCell" forIndexPath:indexPath];
        cell.userID = _user.tmd;
        cell.delegate = self;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _collectionView.bounds.size;
}


#pragma mark - 按钮点击事件

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
