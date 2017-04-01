//
//  BLEScanViewController.h
//  HXInvestigate
//
//  Created by 董富强 on 01/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"

@interface BLEScanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;


@end
