//
//  SetViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetViewController.h"
#import "SetFun01ViewController.h"

#import "XZLHorizontalLineHeaderView.h"

#import "MaskView.h"
#import "CAShapeLayer+MyShape.h"

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;}

NSNumber *DegreesToNumber(CGFloat degrees) {
    return [NSNumber numberWithFloat: DegreesToRadians(degrees)];
}

@interface SetViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *setBtn;

/** 列表视图 */
@property (nonatomic, weak) UITableView *HorizontalLineTableView;

/** 时域范围模型 */
@property (nonatomic, strong) XZLHorizontalLineViewDomain *timeDomain;
/** CellModel的数组 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (nonatomic, strong) CABasicAnimation *pathAnimation;

@end

@implementation SetViewController

- (XZLHorizontalLineViewDomain *)timeDomain {
    
    if (!_timeDomain) {
        
        _timeDomain = [[XZLHorizontalLineViewDomain alloc] init];
        _timeDomain.lineDomainStyle = XZLHorizontalLineViewDomainTwoWeeksStyle;
    }
    return _timeDomain;
}

- (void)viewDidLoad {
    
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    [super viewDidLoad];
    
/*

 */
    CGFloat realH = 20;
    CGFloat realL = 100;
    CGFloat realX = 10;
    CGFloat realY = 10;
    
    CGFloat maskX = realX + realH * 0.25;
    CGFloat maskY = realY + realH * 0.25;
    CGFloat maskL = realL - realH * 0.5;
    CGFloat maskH = realH - realH * 0.5;
    
    //    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    //    [self.layerView.layer addSublayer:shapeLayer];
    //
    //    shapeLayer.strokeColor  = [[UIColor blackColor] CGColor];
    //    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    //    shapeLayer.strokeStart = 0.0;
    //    shapeLayer.strokeEnd = 1.0;
    //    shapeLayer.lineWidth = maskH*0.5;
    //    shapeLayer.frame = CGRectMake(maskX, maskY, maskL, maskH);
    //
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, maskL, maskH) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(shapeLayer.lineWidth, shapeLayer.lineWidth)];
    //    shapeLayer.path = path.CGPath;
    
    //    MaskView *msakView = [[MaskView alloc] initWithFrame:CGRectMake(realX, realY, realL, realH)];
    //    msakView.backgroundColor = [UIColor blackColor];
    //    [self.layerView addSubview:msakView];
    
    
    //    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //    gradientLayer.frame = CGRectMake(shapeLayer.frame.origin.x, shapeLayer.frame.origin.y, shapeLayer.frame.size.width, shapeLayer.frame.size.height*2);
    //    [gradientLayer setColors:[NSArray arrayWithObjects:
    //                              (id)[[UIColor colorFromString_Ext:@"#FF6347"] CGColor],
    //                              [(id)[UIColor colorFromString_Ext:@"#FFEC8B"] CGColor],
    //                              (id)[[UIColor colorFromString_Ext:@"#EEEE00"] CGColor],
    //                              (id)[[UIColor colorFromString_Ext:@"#7FFF00"] CGColor],
    //                              nil]];
    //    [gradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    //    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    //    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    
    for (NSInteger i = 0; i < 3; i++) {
        
        CAShapeLayer *gradientLayer = [CAShapeLayer layer];
        gradientLayer.frame = CGRectMake(realX * i, (realY+realH) * i, realL, realH);
        gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
        gradientLayer.lineWidth = realH;
        gradientLayer.lineCap = kCALineCapButt;
        gradientLayer.lineJoin = kCALineJoinMiter;
        gradientLayer.strokeColor = [UIColor redColor].CGColor;
        
        [gradientLayer addRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft withRadii:CGSizeMake(10, 10)];
        
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:CGPointMake(0, realY)];
        [path1 addLineToPoint:CGPointMake(0 + realL, realY)];
        gradientLayer.path = path1.CGPath;
        
        [self.layerView.layer addSublayer:gradientLayer];
        
//        [CATransaction begin];
//        
//        CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        an.duration = 3;
//        an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        an.fromValue = @(0.0);
//        an.toValue = @(1.0);
//        an.fillMode = kCAFillModeForwards;
//        an.removedOnCompletion = YES;
//        [gradientLayer addAnimation:an forKey:@"strokeEndAnimation"];
//        
//        [CATransaction commit];

    }
    
    
    
//    self.dataSourceArr = [NSMutableArray array];
//    
//    UITableView *HorizontalLineTableView =
//    [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49)
//                                 style:UITableViewStylePlain];
//    HorizontalLineTableView.delegate = self;
//    HorizontalLineTableView.dataSource = self;
//    self.HorizontalLineTableView = HorizontalLineTableView;
//    [self.view addSubview:self.HorizontalLineTableView];
//    
//    [self loadNetDataSrouce];
}



- (CABasicAnimation *)pathAnimation {
    
    if (!_pathAnimation) {
        
        _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _pathAnimation.duration = 10;
        _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _pathAnimation.fromValue = @0.0f;
        _pathAnimation.toValue = @1.0f;
    }
    return _pathAnimation;
}

- (void)loadNetDataSrouce {
    
    self.timeDomain.businessLastValue =
    [[[self class] getSomeDateTimeStamp:[NSString stringWithFormat:@"2017-7-4 0:0"]
                             andItStyle:@"YYYY-M-d H:m"] longLongValue]/1000;
    
    NSArray *arr = @[@[@{@"2017-6-23~2017-6-25":@"1"},@{@"2017-6-29~2017-6-30":@"2"},@{@"2017-7-2~2017-7-3":@"3"}],
                     @[@{@"2017-6-21~2017-6-27":@"1"},@{@"2017-6-30~2017-7-2":@"2"},@{@"2017-7-2~2017-7-4":@"3"}],
                     @[@{@"2017-6-20~2017-6-26":@"1"},@{@"2017-6-29~2017-7-1":@"2"},@{@"2017-7-2~2017-7-3":@"3"}],
                     @[@{@"2017-6-22~2017-6-26":@"1"},@{@"2017-6-30~2017-7-2":@"2"},@{@"2017-7-2~2017-7-4":@"3"}],
                     @[@{@"2017-6-21~2017-6-28":@"1"},@{@"2017-6-29~2017-7-1":@"2"},@{@"2017-7-2~2017-7-3":@"3"}]];
    
    for (NSInteger i = 0; i < 20; i++) {
        
        XZLTableViewCellModel *cellModel = [[XZLTableViewCellModel alloc] initWithDomain:self.timeDomain];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"药物%d",(int)i] forKey:@"name"];
        [dic setObject:arr[i%(arr.count-1)]
                forKey:@"ranges"];
        [cellModel processOriginalDataMdoel:dic];
        [self.dataSourceArr addObject:cellModel];
    }
    
    [self.HorizontalLineTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerId = @"lineHeader";
    XZLHorizontalLineHeaderView *headerView =
    (XZLHorizontalLineHeaderView *)[tableView dequeueReusableCellWithIdentifier:headerId];
    if (!headerView) {
        
        headerView =
        [[XZLHorizontalLineHeaderView alloc] initWithReuseIdentifier:headerId
                                                         andCallBack:^(XZLHorizontalLineViewDomainStyle targetStyle)
        {
            
            
        }];
    }
    
    headerView.timeLineDomain = self.timeDomain;
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    XZLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[XZLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    XZLTableViewCellModel *cellModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    [cell updateCellData:cellModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setBtnClick:(id)sender {
    
    [self updateUserInfoWith:@"dfq" andAge:@"28"];
//    [self performSegueWithIdentifier:@"setViewcontroller001" sender:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)updateUserInfoWith:(NSString *)userName andAge:(NSString *)age {
    
    SetFun01ViewController *twoVc = [[SetFun01ViewController alloc] initWithNibName:@"SetFun01ViewController" bundle:nil];
    twoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:twoVc animated:YES];

}


+ (NSString *)getSomeDateTimeStamp:(NSString *)dateTimeStr
                        andItStyle:(NSString *)styleStr {
    
    NSString *targetTimeStamp = nil;
    
    // 1.将服务器返回的时间格式化为NSDate
    NSDateFormatter *DateF = [[NSDateFormatter alloc] init];
    DateF.locale = [NSLocale currentLocale];
    DateF.dateFormat = styleStr;
    NSDate *createdTime = [DateF dateFromString:dateTimeStr];
    
    targetTimeStamp =
    [NSString stringWithFormat:@"%lld",(long long)[createdTime timeIntervalSince1970]*1000];
    
    return targetTimeStamp;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
