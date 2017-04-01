//
//  HXHomeCellTextView.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXHomeCellMediaView.h"
#import "WFTextView.h"

typedef void (^HomeCellTextViewEventBlock)();

/** >>>>>> cell的文本视图(包括标题和文本内容) <<<<<< */

@interface HXHomeCellTextView : UIView

@property (nonatomic, weak) WFTextView *textContentView;
@property (nonatomic, weak) UIButton *controlTextBtn;//控制文本全文展示、还是收起显示

- (instancetype)initWithEventBlock:(HomeCellTextViewEventBlock)eCom;

- (void)setupHomeCellTextViewWithData:(ClassNewsModel *)cellDataModel andTextR:(HXHomeCellTextRect)textR;
@end
