//
//  DSDaylyController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/16.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDaylyController.h"
#import "DSDrawerController.h"
#import "DSDaylyReusableHeaderView.h"
#import "DSDaylyReusableFooterView.h"
#import "DSDaylyCell.h"
#import "DSApp.h"
#import "Helper.h"
#import "DSDaylyApp.h"
#import "DSDetailController.h"
#import "DSJumpController.h"

@interface DSDaylyController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DSJumpControllerDelegate>
{
    CGFloat _r;
    CGFloat _g;
    CGFloat _b;
    BOOL _selfScroll;
}

@property (nonatomic, strong) NSArray *appArray;

@property (weak, nonatomic) IBOutlet UILabel *bestNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeBtn;


@property (weak, nonatomic) IBOutlet UICollectionView *appCollectionView;


/// collectionView偏移量
@property (nonatomic, assign) CGPoint contentOffset;
// 当前背景颜色
@property (nonatomic, strong) UIColor *currentColor;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger currentSection;
@property (nonatomic, assign, getter=isRefreshNext) BOOL refreshNext;
@property (nonatomic, assign, getter=isRefreshNew) BOOL refreshNew;

@property (nonatomic, weak) DSJumpController *jumpVC;

@end

@implementation DSDaylyController

- (instancetype)init{
    self = [super init];
    if (self) {
        _appArray = [NSArray array];
        _currentpage = 0;
        _currentSection = 1;
        [self setRefreshNext:NO];
        [self setRefreshNew:YES];
    }
    return self;
}

- (void)setType:(DaylyAppType)type{
    _type = type;
    [self loadDataFromNet];
}

+ (instancetype)defaultController {
    static DSDaylyController *daylyVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daylyVC = [[DSDaylyController alloc] init];
    });
    return daylyVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSubviews];
    [self loadDataFromNet];
}

- (void)setSubviews{
    // 设置背景颜色
    self.view.backgroundColor = RandomRGBColor;
    
    _appCollectionView.delegate = self;
    _appCollectionView.dataSource = self;
    
    [_appCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [_appCollectionView registerNib:[UINib nibWithNibName:@"DSDaylyCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [_appCollectionView registerNib:[UINib nibWithNibName:@"DSDaylyReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DSDaylyReusableHeaderView"];
    [_appCollectionView registerNib:[UINib nibWithNibName:@"DSDaylyReusableFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DSDaylyReusableFooterView"];
    _contentOffset = _appCollectionView.contentOffset;
    _currentColor = self.view.backgroundColor;
    
    [self setHeadViewWithApp:nil];
    
    DSJumpController *jumpVC = [[DSJumpController alloc] initWithNibName:@"DSJumpController" bundle:nil];
    CGFloat width = SCREEN_WIDTH / 7;
    CGFloat height = width + 16;
    jumpVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
    jumpVC.space = 4;
    jumpVC.iconNumber = 7;
    jumpVC.delegate = self;
    _jumpVC = jumpVC;
    [self.view addSubview:jumpVC.view];
    [self addChildViewController:jumpVC];
}

// 从网络获取数据
- (void)loadDataFromNet{
    [[HttpRequestManager shareManger] getDaylyInfoWithPage:_currentSection type:(DaylyAppType)_type success:^(id responseObject) {
        
        if (_currentSection == 1) {
            _appArray = nil;
            _appArray = [NSArray array];
        }
        NSArray *array = responseObject;
        for (NSDictionary *dic in array) {
            NSError *error = nil;
            DSDaylyApp *app = [[DSDaylyApp alloc] initWithDictionary:dic error:&error];
            if (error) {
                NSLog(@"初始化每天App数据失败 = %@", error);
            }else{
                _appArray = [_appArray arrayByAddingObject:app];
            }
        }
        [self setRefreshNext:NO];
        [self setRefreshNew:NO];
        [self.appCollectionView reloadData];
        if (_currentSection != 1) {
            [_appCollectionView setContentOffset:CGPointMake((_currentpage + 1) * SCREEN_WIDTH , 0) animated:YES];
        }
        
        _jumpVC.apps = _appArray;
    } failure:^(NSError *error) {
        NSLog(@"获取数据失败%@", error);
        
    }];
}

#pragma mark - UICollectionViewDataSourse
// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _appArray.count;
}

// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSDaylyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.app = nil;
    cell.app = _appArray[indexPath.row];
    return cell;
}

// 返回头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DSDaylyReusableHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DSDaylyReusableHeaderView" forIndexPath:indexPath];
        view = header;
    }
    else {
        DSDaylyReusableFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DSDaylyReusableFooterView" forIndexPath:indexPath];
        view = footer;
    }
    return view;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 返回headerView尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.isRefreshNew) {
        return CGSizeMake(88, 0);
    }else {
        return CGSizeMake(0, 0);
    }
}

// 返回FootView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (self.isRefreshNext) {
        [_appCollectionView setContentOffset:CGPointMake(_currentpage * SCREEN_WIDTH + 88, 0) animated:YES];
        return CGSizeMake(88, 0);
    }else {
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH - 20, _appCollectionView.bounds.size.height);
}

#pragma mark - UICollectionViewDelegate

// 即将高亮某个cell时
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    DSDetailController *detailVC = [[DSDetailController alloc] init];
    detailVC.app = _appArray[indexPath.row];
    detailVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - UIScrollView代理方法
// 开始滚动,设置随机颜色RGB值
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _selfScroll = YES;
    NSLog(@"开始拖动,设置为自身滚动状态");
    _r = (arc4random() % 60 + 98) / 255.0;
    _g = (arc4random() % 60 + 98) / 255.0;
    _b = (arc4random() % 60 + 98) / 255.0;
}

// 滚动过程中改变背景颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_selfScroll) {
        [self changeJumpView];
    }
    CGFloat offsetX = scrollView.contentOffset.x - _contentOffset.x;
    offsetX = offsetX > 0 ? offsetX : -offsetX;
    // 当偏移量超过View的一半时开始渐变背景颜色
    if (offsetX > SCREEN_WIDTH * 0.5 && offsetX < SCREEN_WIDTH) {
        const CGFloat *compoents = CGColorGetComponents(_currentColor.CGColor);
        
        CGFloat addR = (2 * offsetX/ SCREEN_WIDTH - 1) * (_r - compoents[0]) + compoents[0];
        CGFloat addG = (2 * offsetX/ SCREEN_WIDTH - 1) * (_g - compoents[1]) + compoents[1];
        CGFloat addB = (2 * offsetX/ SCREEN_WIDTH - 1) * (_b - compoents[2]) + compoents[2];
        
        self.view.backgroundColor = ColorRGBW(addR, addG, addB, 1);
    }
    
    if (offsetX >= SCREEN_WIDTH) {
        _currentColor = self.view.backgroundColor;
        _contentOffset = self.appCollectionView.contentOffset;
        _currentpage = (long)_contentOffset.x / SCREEN_WIDTH;
        
        DSApp *app = _appArray[_currentpage];
        [self setHeadViewWithApp:app];
        _r = (arc4random() % 60 + 98) / 255.0;
        _g = (arc4random() % 60 + 98) / 255.0;
        _b = (arc4random() % 60 + 98) / 255.0;
    }
}

- (void)changeJumpView{
    NSInteger index;
    if (_refreshNew) {
        index = (NSInteger)((_appCollectionView.contentOffset.x - 88) / SCREEN_WIDTH);
    }else if (_refreshNext) {
        index = (NSInteger)((_appCollectionView.contentOffset.x + 88) / SCREEN_WIDTH);
    }else {
        index = (NSInteger)(_appCollectionView.contentOffset.x / SCREEN_WIDTH);
    }
    [_jumpVC selectItemAtIndex:index];
}

// 设置headView数据,重新记录当前View背景颜色以及collectionView偏移量;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentColor = self.view.backgroundColor;
    _contentOffset = self.appCollectionView.contentOffset;
    _currentpage = (long)_contentOffset.x / SCREEN_WIDTH;
    
    DSApp *app = _appArray[_currentpage];
    [self setHeadViewWithApp:app];
}

// 停止拖动时判断位置,以确认是否刷新数据
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x < -50) {
        _currentSection = 1;
        [self setRefreshNew:YES];
        [self reloadData];
    } else if (scrollView.contentOffset.x > (_appArray.count - 1) * SCREEN_WIDTH + 50) {
        [self setRefreshNext:YES];
        _currentSection++;
        [self reloadData];
    }
}


- (void)reloadData{
    [self.appCollectionView reloadData];
    [self loadDataFromNet];
}

// 设置子视图
- (void)setHeadViewWithApp:(DSApp *)app{
    if (_currentpage < 2 || app == nil) {
        _weekLabel.hidden = YES;
        _dayLabel.hidden = YES;
        _monthLabel.hidden = YES;
        _backToHomeBtn.hidden = YES;
        _bestNowLabel.hidden = NO;
        if (_currentpage == 0 || app == nil) {
            _bestNowLabel.text = @"今日·最美 ";
        }else {
            _bestNowLabel.text = @"昨日·最美 ";
        }
        return;
    }
    _bestNowLabel.hidden = YES;
    _weekLabel.hidden = NO;
    _dayLabel.hidden = NO;
    _monthLabel.hidden = NO;
    _backToHomeBtn.hidden = NO;
    NSDate *date = [Helper dateFromString:app.createTime];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    NSInteger day = [dd day];
    NSInteger weekday = [dd weekday];
    NSInteger month = [dd month];
    NSArray *weekArr = @[@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    _monthLabel.text = [NSString stringWithFormat:@"%02ld月", month];
    _dayLabel.text = [NSString stringWithFormat:@"%ld", day];
    _weekLabel.text = weekArr[weekday - 1];
}

#pragma mark - DSJumpController 代理方法

- (void)jumpControllerDidSelectedItemAtIndex:(NSInteger)index{
    _selfScroll = NO;
    NSLog(@"设置为被动滚动状态");
    [_appCollectionView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
}

#pragma mark - 按钮点击事件
- (IBAction)showMenuViewController{
    [self.drawerVC showMenuViewController];
}

- (IBAction)backToHome{
    [_appCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self setHeadViewWithApp:nil];
    [_jumpVC selectItemAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
