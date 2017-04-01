//
//  HXHomeCellFootView.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "HXHomeCellFootView.h"

@interface HXHomeCellFootView ()
@property (nonatomic, copy) HXHomeCellFootViewCallEvent callCom;
@end

@implementation HXHomeCellFootView

- (instancetype)initWithCallEvent:(HXHomeCellFootViewCallEvent)callEventBlock {
    if (self = [super init]) {
        self.callCom = callEventBlock;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.titleLabel.contentMode = UIViewContentModeLeft;
    [makeSureBtn setTitleColor:[UIColor colorFromString_Ext:@"#98bbe7"] forState:UIControlStateNormal];
    [makeSureBtn setImage:[UIImage imageNamed:@"view--2"] forState:UIControlStateNormal];
    [makeSureBtn setTitle:@"点击确认" forState:UIControlStateNormal];
    [makeSureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [makeSureBtn setImage:[UIImage imageNamed:@"view_1"] forState:UIControlStateSelected];
    [makeSureBtn setTitle:@"已确认" forState:UIControlStateSelected];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [makeSureBtn addTarget:self action:@selector(footFuncBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.makeSureBtn = makeSureBtn;
    [self addSubview:self.makeSureBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [deleteBtn addTarget:self action:@selector(footFuncBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = deleteBtn;
    [self addSubview:self.deleteBtn];
    
    MCFireworksButton *praiseBtn = [[MCFireworksButton alloc]init];
    praiseBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
    praiseBtn.particleScale = 0.1;
    praiseBtn.particleScaleRange = 0.2;
    [praiseBtn setImage :[UIImage imageNamed:@"可点赞"] forState:UIControlStateNormal];
    [praiseBtn setImage:[UIImage imageNamed:@"banjiquan_default_jiazhangdianzan"] forState:UIControlStateSelected];
    [praiseBtn addTarget:self action:@selector(footFuncBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.praiseBtn = praiseBtn;
    [self addSubview:self.praiseBtn];
    
    UIImageView *separateLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fengeLine"]];
    self.separateLine = separateLine;
    [self addSubview:separateLine];
    
    UILabel *praiseLabel = [[UILabel alloc] init];
    praiseLabel.numberOfLines = 0;
    praiseLabel.font = [UIFont systemFontOfSize:TextSize];
    self.praisePeopleLabel = praiseLabel;
    [self addSubview:self.praisePeopleLabel];
    
}

- (void)setupFootViewWithCellData:(ClassNewsModel *)cellDataModel andFootViewF:(HXHomeCellFootRect)footR {
    
    self.praiseBtn.enabled = YES;
    self.makeSureBtn.enabled = YES;
    self.deleteBtn.enabled = YES;
    
    self.makeSureBtn.frame = footR.sureBtnF;
    self.deleteBtn.frame = footR.delBtnF;
    self.separateLine.frame = footR.lineViewF;
    self.praiseBtn.frame = footR.praiseBtnF;
    self.praisePeopleLabel.frame = footR.praiserLF;
    
    self.makeSureBtn.selected = cellDataModel.cellContentBox.isSelectedSureBtn;
    self.makeSureBtn.hidden = cellDataModel.cellContentBox.isHiddenSureBtn;
    self.deleteBtn.hidden = cellDataModel.cellContentBox.isHiddenDelBtn;
    self.praiseBtn.selected = cellDataModel.cellContentBox.isClickedPraise;
    
    self.praisePeopleLabel.text = cellDataModel.cellContentBox.praisePeoplesStr;
}

- (void)footFuncBtnClicked:(UIButton *)funcBtn {
    
    HXHomeCellFootViewEventType eType = HXHomeCellFootViewNoneEventType;
    if (funcBtn == self.makeSureBtn) {
        if (!funcBtn.selected) {
            
            eType = HXHomeCellFootViewNeedConfimEventType;
            funcBtn.selected = YES;
            funcBtn.enabled = NO;
        } else {
            
            eType = HXHomeCellFootViewHadConfirmEventType;
        }
    } else if (funcBtn == self.deleteBtn) {
        
        eType = HXHomeCellFootViewDeleteMsgEventType;
        funcBtn.enabled = NO;
    } else if (funcBtn == self.praiseBtn) {
        
        if (!funcBtn.selected) {
            eType = HXHomeCellFootViewNeedPraiseMsgEventType;
            funcBtn.selected = YES;
            funcBtn.enabled = NO;
        } else {
            
            eType = HXHomeCellFootViewHadPraisedMsgEventType;
//            [MBProgressHUD showMessageWithNoneIcon:@"您已经点过赞了哦" delay:0.75 toView:[[ChooseViewController getCurrentViewController] view]];
        }
    }
    
    if (self.callCom) {
        self.callCom(eType);
    }
}

@end
