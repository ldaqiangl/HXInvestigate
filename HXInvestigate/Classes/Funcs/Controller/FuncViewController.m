//
//  FuncViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/26.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "FuncViewController.h"

#import "NetDataModel.h"

#import "BSMultiMenuView.h"
#import "SDCycleScrollView.h"
#import "BSContainerTableView.h"
#import "UIViewController+NJKFullScreenSupport.h"

#define w [[UIScreen mainScreen] bounds].size.width
#define h [[UIScreen mainScreen] bounds].size.height

@interface FuncViewController ()
<SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

{
    int total;
    CGFloat _movedS;
    CGFloat _preOffY;
}

@property (nonatomic, assign) ListStateType listState;


@property (nonatomic, strong) NSMutableArray *titleModels;
@property (nonatomic, strong) NSMutableArray *dataModels;

/** 平台容器view */
@property (nonatomic, weak) BSContainerTableView *platformView;
@property (nonatomic, weak) SDCycleScrollView *iadView;
@property (nonatomic, strong) BSMultiMenuView *multiMenuView;

@end

@implementation FuncViewController


#pragma mark - <懒加载> -

- (UITableView *)platformView {
    if (!_platformView) {
            
        BSContainerTableView *platformView = [[BSContainerTableView alloc] initWithFrame:CGRectMake(0, BS_STATEBAR_H+BS_NAV_H, w, h-BS_TABBAR_H-(BS_STATEBAR_H+BS_NAV_H)) style:UITableViewStylePlain];
        platformView.contentInset = UIEdgeInsetsMake(HeadViewHeight, 0, 0, 0);
        platformView.delegate = self;
        platformView.dataSource = self;
        platformView.backgroundColor = [UIColor blueColor];
//        platformView.bounces = NO;
        _platformView = platformView;
        [self.view addSubview:platformView];
        
    }
    return _platformView;
}



#pragma mark - <super method 视图加载> -

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titleModels = [NSMutableArray array];
    self.dataModels = [NSMutableArray array];
    
    self.listState = eListStateNormalType;
    
    [self setupIADView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

#pragma mark - <数据源加载> -

/** 加载本地缓存数据 */
- (void)loadLocalCacheData {
    
    for (int i = 0; i < 20; i++) {
        NetDataModel *data = [[NetDataModel alloc] init];
//        data.lable = @"新闻";
        [self.dataModels addObject:data];
    }
}

/** 加载网络数据 */
- (void)loadNetData {
    
}



#pragma mark - <视图加载> -

- (void)setupIADView {
    
    
    NSArray *imagesURLStrings = @[
                                  @"http://pic21.nipic.com/20120530/10116020_112329148129_2.jpg",
                                  @"http://pic1.nipic.com/2008-10-20/20081020191125403_2.jpg",
                                  @"http://www.dabaoku.com/sucai/renwu/yingerxiaohai/139fi.jpg"
                                  ];
    
    NSArray *titles = @[@"幼儿园选址",
                        @"宝妈孕育知识精选",
                        @"宝宝推荐",
                        @"关爱宝宝健康"
                        ];
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -HeadViewHeight, w, HeadViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.titlesGroup = titles;
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    self.iadView = cycleScrollView3;
    [self.platformView addSubview:cycleScrollView3];
    _platformView = self.platformView;
    
}



#pragma mark - <UITableViewDelegate & UITableViewDataSource> -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.bounds.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell addSubview:[self setPageViewControllers]];
    
    return cell;
}


- (BSMultiMenuView *)setPageViewControllers {
    
    if (!_multiMenuView) {
        
        BSMultiMenuView *multiMenuView = [[BSMultiMenuView alloc] initWithFrame:CGRectMake(0, 0, w, CGRectGetHeight(self.platformView.frame))];
        multiMenuView.managerVc = self;
        multiMenuView.backgroundColor = [UIColor redColor];
        _multiMenuView = multiMenuView;
    }
    
    NSArray *titlesArr = @[@"全部",@"table2",@"tableList3",
                           @"tablet4",@"BSBStableList5",@"tableList6",
                           @"tableList6",@"tableList7",@"tableList8",
                           @"tableList9"];
    [_multiMenuView setTitlesArr:[NSMutableArray arrayWithArray:titlesArr]];
    
    return _multiMenuView;
}

#pragma mark - <UIScrollViewDelegate> -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offY = scrollView.contentOffset.y;
    
    if (offY >= 0) {
        
        self.listState = eListStateTopType;
        scrollView.contentOffset = CGPointMake(0, 0);
        
    } else {
        
        if (offY > -HeadViewHeight) {
            
            self.listState = eListStateNormalTopType;
            
        } else if (offY == -HeadViewHeight) {
            
            self.listState = eListStateNormalType;
            scrollView.contentOffset = CGPointMake(0, -HeadViewHeight);
            
        } else if (offY < -HeadViewHeight) {
            
            self.listState = eListStateNormalDownType;
            scrollView.contentOffset = CGPointMake(0, -HeadViewHeight);
            
        }
    }
    
    
    _preOffY = offY;
}



- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
