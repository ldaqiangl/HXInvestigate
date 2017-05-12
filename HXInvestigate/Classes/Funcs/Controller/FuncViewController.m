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
            
        BSContainerTableView *platformView =
        [[BSContainerTableView alloc] initWithFrame:CGRectMake(0,
                                                               BS_STATEBAR_H+BS_NAV_H,
                                                               w,
                                                               h-BS_TABBAR_H-(BS_STATEBAR_H+BS_NAV_H))
                                              style:UITableViewStylePlain];
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
    self.view.backgroundColor = [UIColor blueColor];
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
                                  @"http://image.baidu.com/search/detail?z=0&ipn=d&word=%E5%AE%9D%E5%AE%9D&step_word=&hs=0&pn=2&spn=0&di=0&pi=&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&cs=2669037263%2C3258252549&os=2690160171%2C3145911115&simid=&adpicid=0&lpn=0&fm=&sme=&cg=&bdtype=14&simics=3987397520%2C3449139104&oriquery=&objurl=http%3A%2F%2Fcomp.quanjing.com%2Fpix_foto3%2Fpix-we057044.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bq7wg3tg2_z%26e3Bv54AzdH3Ffiw6jAzdH3Frtx-ojac0a99_z%26e3Bip4s&gsm=0&cardserver=1",
                                  @"http://ww1.sinaimg.cn/large/904e7788gw1eovx0vbo0tj21hc0xcqeg.jpg",
                                  @"http://www.baby611.com/pic/userup/1001/2910094J101.jpg"
                                  ];
    
    NSArray *titles = @[@"幼儿园选址",
                        @"宝妈孕育知识精选",
                        @"宝宝推荐",
                        @"关爱宝宝健康"
                        ];
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -HeadViewHeight, w, HeadViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder1"]];
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
