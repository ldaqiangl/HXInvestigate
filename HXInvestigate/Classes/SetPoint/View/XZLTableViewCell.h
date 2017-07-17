//
//  XZLTableViewCell.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZLHorizontalLineView.h"
#import "XZLHorizontalLineViewDomain.h"

@class XZLTableViewCellModel;
@interface XZLTableViewCell : UITableViewCell

@property (nonatomic, weak) XZLHorizontalLineView *horizontalLineView;
@property (nonatomic, weak) UILabel *titleLabel;

- (void)updateCellData:(XZLTableViewCellModel *)cellModel;

@end


@interface XZLTableViewCellModel : NSObject

@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, copy) NSString *medicineName;

/** 持有外界控制器指定的时域模型，方便获取其中的因数和方法 */
@property (nonatomic, weak) XZLHorizontalLineViewDomain *timeLineDomain;
/** 一个时间轴域内 所有节点模型的数组 */
@property (nonatomic, strong, readonly) NSArray *nodeRangesArr;

@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect timeLineViewF;

@property (nonatomic, assign, readonly) CGFloat cellH;


- (instancetype)initWithDomain:(XZLHorizontalLineViewDomain *)timeLineDomain;
- (void)processOriginalDataMdoel:(NSObject *)dataModel;

@end












