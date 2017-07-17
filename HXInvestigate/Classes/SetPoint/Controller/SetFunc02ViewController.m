
//
//  SetFunc02ViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetFunc02ViewController.h"
#import "SetDrawView.h"

@interface SetFunc02ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end

@implementation SetFunc02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SetDrawView *v = [[SetDrawView alloc] initWithFrame:CGRectMake(10, 100, 200, 300)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
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
