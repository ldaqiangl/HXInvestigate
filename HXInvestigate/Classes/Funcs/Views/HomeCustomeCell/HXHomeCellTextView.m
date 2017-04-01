//
//  HXHomeCellTextView.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "HXHomeCellTextView.h"

@interface HXHomeCellTextView ()
@property (nonatomic, copy) HomeCellTextViewEventBlock clickCom;
@end

@implementation HXHomeCellTextView

- (instancetype)initWithEventBlock:(HomeCellTextViewEventBlock)eCom {
    if (self = [super init]) {
        
        self.clickCom = eCom;
        
        WFTextView *textView = [[WFTextView alloc] initWithFrame:CGRectZero];
        self.textContentView = textView;
        [self addSubview:self.textContentView];
        
        UIButton *controlTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        controlTextBtn.titleLabel.font = [UIFont systemFontOfSize:TextSize];
        [controlTextBtn  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [controlTextBtn addTarget:self action:@selector(controlTextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.controlTextBtn = controlTextBtn;
        [self addSubview:self.controlTextBtn];
        
#if 0
        textView.backgroundColor = [UIColor redColor];
        controlTextBtn.backgroundColor = [UIColor greenColor];
#endif
    }
    return self;
}

- (void)setupHomeCellTextViewWithData:(ClassNewsModel *)cellDataModel andTextR:(HXHomeCellTextRect)textR {
    
    self.textContentView.frame = textR.textContentF;
    self.controlTextBtn.frame = textR.controlBtnF;
    
    //属性数据    //WFTextView附带的点击区域数组
    self.textContentView.attributedData = cellDataModel.attributedDataWF;
    self.textContentView.isFold = !cellDataModel.cellContentBox.isOpen;
    self.textContentView.isDraw = YES;
    [self.textContentView setOldString:cellDataModel.content andNewString:cellDataModel.cellContentBox.textContent];
    
    if (!cellDataModel.cellContentBox.isHiddenControlBtn) {
        NSString *title = cellDataModel.cellContentBox.isOpen?@"收起":@"全文";
        [self.controlTextBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)controlTextBtnClicked {
    if (self.clickCom) {
        self.clickCom();
    }
}

@end
