//
//  DSDaylyController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/11.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDaylyController.h"
#import "DSApp.h"
#import "DSDaylyCell.h"
#import "Helper.h"
#import "DSDetailController.h"
#import "DSDrawerController.h"

@interface DSDaylyController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UILabel *_monthLabel;
    UILabel *_weekLabel;
    UILabel *_dayLabel;
    UIButton *_backToHomeBtn;
    UILabel *_bestLabel;
    
    CGFloat _r;
    CGFloat _g;
    CGFloat _b;
}
@property (nonatomic, strong) UICollectionView *appCollectionView;
@property (nonatomic, strong) NSArray *appArray;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) NSInteger currentpage;


@end

@implementation DSDaylyController

- (instancetype)init{
    self = [super init];
    if (self) {
        _appArray = [NSArray array];
        _currentpage = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubViews];
    [self loadDataFromNet];
}

// 从网络获取数据
- (void)loadDataFromNet{
    if (_currentpage == 1) {
        _appArray = nil;
        _appArray = [NSArray array];
    }
    [[HttpRequestManager shareManger] getDaylyInfoWithPage:_currentpage type:(DaylyAppType)_type success:^(id responseObject) {
        // NSLog(@"responseObject = %@", responseObject);
        NSArray *array = responseObject;
        for (NSDictionary *dic in array) {
            DSApp *app = [DSApp appWithDictionary:dic];
            _appArray = [_appArray arrayByAddingObject:app];
        }
        [self.appCollectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"获取数据失败%@", error);
        
    }];
}

// 添加子视图
- (void)addSubViews{
    // 设置背景颜色
    self.view.backgroundColor = RandomRGBColor;
    
    CGFloat headW = SCREEN_WIDTH;
    CGFloat headH = 26 + 2 * Space;
    CGFloat headX = 0;
    CGFloat headY = 20;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    
    // 添加顶部'最美应用button'
    UIButton *bestAppBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    CGFloat bestBtnW = 137;
    CGFloat bestBtnH = 26;
    CGFloat bestBtnX = Space;
    CGFloat bestBtnY = Space;
    bestAppBtn.frame = CGRectMake(bestBtnX, bestBtnY, bestBtnW, bestBtnH);
    [bestAppBtn setBackgroundImage:[UIImage imageNamed:@"common_logo_normal.png"] forState:UIControlStateNormal];
    [bestAppBtn setBackgroundImage:[UIImage imageNamed:@"common_logo_pressed.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:bestAppBtn];
    [bestAppBtn addTarget:self.drawerVC action:@selector(showMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:bestAppBtn];
    
    // 添加今日最美以及昨日最美label
    CGFloat bestW = 100;
    CGFloat bestH = bestBtnH;
    CGFloat bestX = SCREEN_WIDTH - bestW - Space;
    CGFloat bestY = Space;
    _bestLabel = [[UILabel alloc] initWithFrame:CGRectMake(bestX, bestY, bestW, bestH)];
    _bestLabel.hidden = YES;
    _bestLabel.textColor = [UIColor whiteColor];
    _bestLabel.font = [UIFont systemFontOfSize:20 weight:2];
    _bestLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:_bestLabel];
    
    // 添加顶部日期标示
    // 月
    CGFloat monthW = 50;
    CGFloat monthH = bestBtnH * 0.5;
    CGFloat monthX = SCREEN_WIDTH - monthW - Space;
    CGFloat monthY = bestBtnY;
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthX, monthY, monthW, monthH)];
    _monthLabel.text = @"9月";
    _monthLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    _monthLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_monthLabel];
    // 周
    CGFloat weekW = monthW;
    CGFloat weekH = monthH;
    CGFloat weekX = monthX;
    CGFloat weekY = monthY + monthH + 2;
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(weekX, weekY, weekW, weekH)];
    _weekLabel.text = @"星期五";
    _weekLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    _weekLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_weekLabel];
    
    // 天
    CGFloat dayW = monthW;
    CGFloat dayH = monthH * 2;
    CGFloat dayX = monthX - dayW;
    CGFloat dayY = monthY;
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(dayX, dayY, dayW, dayH)];
    _dayLabel.text = @"09";
    _dayLabel.textColor = [UIColor whiteColor];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    _dayLabel.font = [UIFont systemFontOfSize:32];
    [headView addSubview:_dayLabel];
    
    // 返回首页
    CGFloat backW = dayH + Space;
    CGFloat backH = backW;
    CGFloat backX = dayX - backW;
    CGFloat backY = dayY * 0.5;
    _backToHomeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backToHomeBtn.frame = CGRectMake(backX, backY, backW, backH);
    [_backToHomeBtn setBackgroundImage:[UIImage imageNamed:@"backtohome_normal"] forState:UIControlStateNormal];
    [_backToHomeBtn setBackgroundImage:[UIImage imageNamed:@"backtohome_pressed"] forState:UIControlStateHighlighted];
    [_backToHomeBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_backToHomeBtn];
    
    // 添加CollectionView
    // 布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing  = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.height - 156);
    
    // 根据布局类创建CollectionView
    _appCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height - 156) collectionViewLayout:layout];
    
    _appCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 10);
    _appCollectionView.backgroundColor = [UIColor clearColor];
    _appCollectionView.delegate = self;
    _appCollectionView.dataSource = self;
    _appCollectionView.alwaysBounceHorizontal = YES;
    _appCollectionView.pagingEnabled = YES;
    _appCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_appCollectionView];
    
    [_appCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [_appCollectionView registerNib:[UINib nibWithNibName:@"DSDaylyCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    _contentOffset = _appCollectionView.contentOffset;
    _currentColor = self.view.backgroundColor;
    
    [self setHeadViewWithApp:nil];
    
}

// 设置子视图
- (void)setHeadViewWithApp:(DSApp *)app{
    if (_currentpage < 2 || app == nil) {
        _weekLabel.hidden = YES;
        _dayLabel.hidden = YES;
        _monthLabel.hidden = YES;
        _backToHomeBtn.hidden = YES;
        _bestLabel.hidden = NO;
        if (_currentpage == 0 || app == nil) {
            _bestLabel.text = @"今日·最美 ";
        }else {
            _bestLabel.text = @"昨日·最美 ";
        }
        return;
    }
    _bestLabel.hidden = YES;
    _weekLabel.hidden = NO;
    _dayLabel.hidden = NO;
    _monthLabel.hidden = NO;
    _backToHomeBtn.hidden = NO;
    NSDate *date = [Helper dateFromString:app.createTime];
    NSLog(@"%@", date);
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

#pragma mark - 按钮点击事件

// 返回首页
- (void)backToHome{
    [_appCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self setHeadViewWithApp:nil];
}


#pragma mark - UICollectionView 代理方法
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

// 返回headerView尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(10, 0);
}

#pragma mark - UIScrollView代理方法
// 开始滚动,设置随机颜色RGB值
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _r = (arc4random() % 60 + 98) / 255.0;
    _g = (arc4random() % 60 + 98) / 255.0;
    _b = (arc4random() % 60 + 98) / 255.0;
}

// 滚动过程中改变背景颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x - _contentOffset.x;
    offsetX = offsetX > 0 ? offsetX : -offsetX;
    // 当偏移量超过View的一半时开始渐变背景颜色
    if (offsetX > SCREEN_WIDTH * 0.5) {
        const CGFloat *compoents = CGColorGetComponents(_currentColor.CGColor);
        
        CGFloat addR = (2 * offsetX/ SCREEN_WIDTH - 1) * (_r - compoents[0]) + compoents[0];
        CGFloat addG = (2 * offsetX/ SCREEN_WIDTH - 1) * (_g - compoents[1]) + compoents[1];
        CGFloat addB = (2 * offsetX/ SCREEN_WIDTH - 1) * (_b - compoents[2]) + compoents[2];
        
        self.view.backgroundColor = ColorRGBW(addR, addG, addB, 1);
    }
}

// 设置headView数据,重新记录当前View背景颜色以及collectionView偏移量;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentColor = self.view.backgroundColor;
    _contentOffset = self.appCollectionView.contentOffset;
    _currentpage = (long)_contentOffset.x / SCREEN_WIDTH;
    
    DSApp *app = _appArray[_currentpage];
    [self setHeadViewWithApp:app];
}




#pragma mark - 收到内存警告调用方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
