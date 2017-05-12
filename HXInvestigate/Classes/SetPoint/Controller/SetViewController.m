//
//  SetViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetViewController.h"
#import "SetFun01ViewController.h"


@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setBtnClick:(id)sender {
    
    //[self updateUserInfoWith:@"dfq" andAge:@"28"];
    [self performSegueWithIdentifier:@"setViewcontroller001" sender:nil];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
