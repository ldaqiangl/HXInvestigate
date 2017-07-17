//
//  XZLHorizontalLineHeaderView.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/4.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZLTableViewCell.h"

typedef void (^SwitchCallBack)(XZLHorizontalLineViewDomainStyle targetStyle);

@interface XZLHorizontalLineHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) XZLHorizontalLineViewDomain *timeLineDomain;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                            andCallBack:(SwitchCallBack)switchCallBack;

@end
