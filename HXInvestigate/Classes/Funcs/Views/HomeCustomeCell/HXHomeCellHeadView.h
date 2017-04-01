//
//  HXHomeCellHeadView.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXHomeCellTextView.h"

@class HXHomeCellHeadTypeView;

typedef NS_OPTIONS(NSInteger, HXHomeCellHeadViewEventType) {
    HXHomeCellHeadViewNoneEventType = 10,
    HXHomeCellHeadViewHeadIconEventType = 11,
    HXHomeCellHeadViewResendMsgEventType = 12,
};

typedef void (^HXHomeCellHeadViewCallEvent)(HXHomeCellHeadViewEventType headEType);

/** >>>>>> cell的头视图 <<<<<< */

@interface HXHomeCellHeadView : UIView

@property (nonatomic, weak) UIImageView *headIconBtn;//头像
@property (nonatomic, weak) UILabel *nameLabel;//名称
@property (nonatomic, weak) UILabel *roleTitleLabel;//角色：老师 等
@property (nonatomic, weak) UILabel *timeLabel;//时间
@property (nonatomic, weak) HXHomeCellHeadTypeView *typeLabelView;//标签视图
@property (nonatomic, weak) UIButton *resendBtn;//发送失败的时候，重发按钮显示，供用户重新发送

- (instancetype)initWithCallEvent:(HXHomeCellHeadViewCallEvent)callEventBlock;

- (void)setupHomeCellHeadViewWithData:(ClassNewsModel *)cellDataModel andHeadR:(HXHomeCellHeadRect)headR;
@end


/** >>>>>> 每条内容的标签视图 <<<<<< */

@interface HXHomeCellHeadTypeView : UIView

@property (nonatomic, weak) UILabel *preLabel;//标签前缀
@property (nonatomic, weak) UILabel *tagContentLabel;//标签内容

- (void)setupHomeCellHeadTypeViewhData:(ClassNewsModel *)cellDataModel;
@end










