//
//  HXHomeCellHeadView.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#pragma mark - >>>>>> cell的头视图 <<<<<< -
#import "HXHomeCellHeadView.h"

@interface HXHomeCellHeadView ()
@property (nonatomic, copy) HXHomeCellHeadViewCallEvent callCom;
@end

@implementation HXHomeCellHeadView

- (instancetype)initWithCallEvent:(HXHomeCellHeadViewCallEvent)callEventBlock {
    if (self = [super init]) {
        
        self.callCom = callEventBlock;
        [self setupView];
        
    }
    return self;
}


- (void)setupView {
    
    UIImageView *headIconBtn = [[UIImageView alloc] init];
    self.headIconBtn = headIconBtn;
    [self addSubview:self.headIconBtn];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:self.nameLabel];
    
    UILabel *roleTitleLabel = [[UILabel alloc] init];
    roleTitleLabel.textColor = [UIColor lightGrayColor];
    self.roleTitleLabel = roleTitleLabel;
    [self addSubview:self.roleTitleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel = timeLabel;
    [self addSubview:self.timeLabel];
    
    HXHomeCellHeadTypeView *typeLabelView = [[HXHomeCellHeadTypeView alloc] init];
    self.typeLabelView = typeLabelView;
    [self addSubview:self.typeLabelView];
    
    UIButton *resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resendBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [resendBtn setTitle:HXHomeCellResendingText forState:UIControlStateNormal];
    [resendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [resendBtn addTarget:self action:@selector(headViewFuncEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.resendBtn = resendBtn;
    [self addSubview:resendBtn];
    
    self.nameLabel.font = [UIFont systemFontOfSize:NameSize];
    self.roleTitleLabel.font = [UIFont systemFontOfSize:TimeSize];
    self.timeLabel.font = [UIFont systemFontOfSize:TimeSize];
    [self.resendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
#if 0
    self.headIconBtn.backgroundColor = [UIColor greenColor];
    self.nameLabel.backgroundColor = [UIColor blueColor];
    self.roleTitleLabel.backgroundColor = [UIColor orangeColor];
    self.timeLabel.backgroundColor = [UIColor purpleColor];
    self.typeLabelView.backgroundColor = [UIColor greenColor];
    resendBtn.backgroundColor = [UIColor yellowColor];
#endif
    
}

- (void)setupHomeCellHeadViewWithData:(ClassNewsModel *)cellDataModel andHeadR:(HXHomeCellHeadRect)headR {
    
    self.headIconBtn.frame = headR.iconF;
    self.nameLabel.frame = headR.nameLabelF;
    self.roleTitleLabel.frame = headR.roleTitleF;
    self.timeLabel.frame = headR.timeLabelF;
    self.typeLabelView.frame = headR.tagViewF.tagViewF;
    self.resendBtn.frame = headR.resendBtnF;
    self.resendBtn.hidden = !cellDataModel.cellContentBox.retrySending;
    
//    [self.headIconBtn sd_setImageWithURL:ImageURLWithMD5(cellDataModel.creator_avatar)
//                        placeholderImage:ImageWithName(cellDataModel.creator_display_name)];
    self.nameLabel.text = cellDataModel.creator_display_name;
    self.roleTitleLabel.text = cellDataModel.cellContentBox.roleTitle;
    self.timeLabel.text = cellDataModel.cellContentBox.time;
    
    [self.typeLabelView setupHomeCellHeadTypeViewhData:cellDataModel];
    
    if ([cellDataModel.is_owner isEqualToString:@"1"]) {
        
        // 更新用户头像
//        ParentInfoCenter *userInfo = [ParentInfoCenter sharedParentInfoCenter];
//        NSString *currentAvatar = userInfo.currentChildInfo.user_avatar;
//        if (![currentAvatar isEqualToString:cellDataModel.creator_avatar]) {
//            [self.headIconBtn sd_setImageWithURL:ImageURLWithMD5(currentAvatar)
//                              placeholderImage:ImageWithName(cellDataModel.creator_display_name)];
//        }
    }
}

- (void)headViewFuncEvent:(UIButton *)sender {
    
    if (self.callCom) {
        self.callCom(HXHomeCellHeadViewResendMsgEventType);
    }
}


@end


#pragma mark - >>>>>> 每条内容的标签视图 <<<<<< -

@implementation HXHomeCellHeadTypeView

- (instancetype)init {
    
    if (self = [super init]) {
        
        UILabel *preLabel = [[UILabel alloc] init];
        self.preLabel = preLabel;
        [self addSubview:self.preLabel];
        
        UILabel *tagContentLabel = [[UILabel alloc] init];
        self.tagContentLabel = tagContentLabel;
        [self addSubview:self.tagContentLabel];
        
        self.preLabel.font = [UIFont systemFontOfSize:TapLabelSize];
        self.tagContentLabel.font = [UIFont systemFontOfSize:TapLabelSize];
        
#if 0
        preLabel.backgroundColor = [UIColor blueColor];
        tagContentLabel.backgroundColor = [UIColor cyanColor];
#endif
        
    }
    return self;
}

- (void)setupHomeCellHeadTypeViewhData:(ClassNewsModel *)cellDataModel {
    
    HXHomeCellHeadRect headF = HXHomeCellHeadRectFromString(cellDataModel.headViewF);
    
    self.preLabel.frame = headF.tagViewF.tagTitleF;
    self.tagContentLabel.frame = headF.tagViewF.tagLabelF;
    
    self.preLabel.text = cellDataModel.cellContentBox.labelPre;
    self.tagContentLabel.text = cellDataModel.cellContentBox.labelContent;
    self.tagContentLabel.textColor = [UIColor colorFromString_Ext:cellDataModel.cellContentBox.labelColor];
    
}


@end