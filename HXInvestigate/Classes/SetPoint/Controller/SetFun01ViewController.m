//
//  SetFun01ViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetFun01ViewController.h"
#import "SetFunc02ViewController.h"

@interface SetFun01ViewController ()

@end

@implementation SetFun01ViewController

- (IBAction)funcBtnClicked:(id)sender {
//    SetFunc02ViewController *func02Vc = [[SetFunc02ViewController alloc] initWithNibName:@"SetFunc02ViewController" bundle:nil];
//    [self.navigationController pushViewController:func02Vc animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        self.tabBarController.selectedIndex = 0;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
