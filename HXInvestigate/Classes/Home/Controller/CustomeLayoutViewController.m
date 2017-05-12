//
//  CustomeLayoutViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 08/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import "CustomeLayoutViewController.h"
#import "LayoutView01.h"

@interface CustomeLayoutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@end

@implementation CustomeLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.testBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.testBtn.hidden = YES;
    [self exp01];
}

- (void)exp01 {
    
    LayoutView01 *view = [[LayoutView01 alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    
    NSLayoutConstraint *constraint;
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
//    NSDictionary *dic = @{@"subView":view};
//    NSArray *yCons = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[subView]-|" options:0 metrics:nil views:dic];
//    NSArray *xCons = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subView]-|" options:0 metrics:nil views:dic];
//    [self.view addConstraints:yCons];
//    [self.view addConstraints:xCons];
    
//    [view updateImgView:@"1122.png"];
//    [view setNeedsLayout];
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

@end
