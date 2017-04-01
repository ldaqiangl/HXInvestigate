//
//  HXHomeCellFootView.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassNewsModel.h"
#import "MCFireworksButton.h"

typedef NS_OPTIONS(NSInteger, HXHomeCellFootViewEventType) {
    HXHomeCellFootViewNoneEventType = 40,//没有任何事件
    HXHomeCellFootViewNeedConfimEventType = 41,//确认事件（还没有确认，需要确认）
    HXHomeCellFootViewHadConfirmEventType = 42,//已经确认了
    HXHomeCellFootViewDeleteMsgEventType = 43,//删除事件
    HXHomeCellFootViewNeedPraiseMsgEventType = 44,//点赞事件（还没有点赞，需要点赞）
    HXHomeCellFootViewHadPraisedMsgEventType = 45,//已经点赞过了
};
typedef void (^HXHomeCellFootViewCallEvent)(HXHomeCellFootViewEventType footEvType);

/** >>>>>> cell的尾部功能视图 <<<<<< */

@interface HXHomeCellFootView : UIView

@property (nonatomic, weak) UIButton *makeSureBtn;
@property (nonatomic, weak) UIButton *deleteBtn;

@property (nonatomic, weak) MCFireworksButton *praiseBtn;

@property (nonatomic, weak) UIImageView *separateLine;//分割线
@property (nonatomic, weak) UILabel *praisePeopleLabel;

- (instancetype)initWithCallEvent:(HXHomeCellFootViewCallEvent)callEventBlock;

- (void)setupFootViewWithCellData:(ClassNewsModel *)cellDataModel andFootViewF:(HXHomeCellFootRect)footR;

@end
