//
//  HXHomeTableViewCell.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "HXHomeTableViewCell.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

//#import "GetClassNewsListInterface.h"
//#import "ClassNewsBusiness.h"
//#import "ChooseViewController.h"
//#import "DBBusinessUtil.h"

@interface HXHomeTableViewCell ()

@property (nonatomic, copy) HXHomeCellEventCallBlock eventCall;

@end

@implementation HXHomeTableViewCell

#pragma mark - <首页的cell和内部子视图 初始化> -

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andEventCall:(HXHomeCellEventCallBlock)eventCallBlock {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.eventCall = eventCallBlock;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    __weak __typeof(self)weakSelf = self;
    
    //初始化头部视图
    HXHomeCellHeadView *headView = [[HXHomeCellHeadView alloc] initWithCallEvent:^(HXHomeCellHeadViewEventType headEType) {
        if (headEType == HXHomeCellHeadViewResendMsgEventType) {
//            [weakSelf resendMsg];
        }
    }];
    self.headView = headView;
    [self.contentView addSubview:headView];
    
    //初始化文本视图和回调事件
    HXHomeCellTextView *textContentView = [[HXHomeCellTextView alloc] initWithEventBlock:^{
        
        __weak __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.eventCall) {
            self.eventCall(eHomeCellTextDisplayControlType,_cellDataModel);
        }
    }];
    self.textContentView = textContentView;
    [self.contentView addSubview:textContentView];
    
    //初始化多媒体视图和回调事件
    HXHomeCellMediaView *mediaView = [[HXHomeCellMediaView alloc] initWithCallEvent:^(HXHomeCellImageView *picImgView, NSInteger picIndex) {
        [weakSelf clickOnePicWithPicImgView:picImgView andIndex:picIndex];
    }];
    self.mediaView = mediaView;
    [self.contentView addSubview:mediaView];
    
    //初始化底部功能视图和回调事件
    HXHomeCellFootView *footFuncView = [[HXHomeCellFootView alloc] initWithCallEvent:^(HXHomeCellFootViewEventType footEvType) {
        __weak __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf footViewFuncBtnClicked:footEvType];
    }];
    self.footFuncView = footFuncView;
    [self.contentView addSubview:footFuncView];
    
    
#if 0
    headView.backgroundColor = [UIColor greenColor];
    textContentView.backgroundColor = [UIColor purpleColor];
    mediaView.backgroundColor = [UIColor blueColor];
    footFuncView.backgroundColor = [UIColor cyanColor];
#endif
    
}

#pragma mark - <数据加载和显示> -

- (void)setupHomeTableViewCellWithData:(ClassNewsModel *)cellDataModel {
    
    _cellDataModel = cellDataModel;
    
    //
    HXHomeCellHeadRect headR = HXHomeCellHeadRectFromString(cellDataModel.headViewF);
    self.headView.frame = headR.headViewF;
    [self.headView setupHomeCellHeadViewWithData:cellDataModel andHeadR:headR];
    //
    HXHomeCellTextRect textR = HXHomeCellTextRectFromString(cellDataModel.textViewF);
    self.textContentView.frame = textR.textViewF;
    [self.textContentView setupHomeCellTextViewWithData:cellDataModel andTextR:textR];
    //
    HXHomeCellMediaRect mediaR = HXHomeCellMediaRectFromString(cellDataModel.mediaViewF);
    self.mediaView.frame = mediaR.mediaViewF;
    [self.mediaView setupHomeCellMediaViewWithData:cellDataModel andMediaR:mediaR];
    //
    HXHomeCellFootRect footR = HXHomeCellFootRectFromString(cellDataModel.footViewF);
    self.footFuncView.frame = footR.footViewF;
    [self.footFuncView setupFootViewWithCellData:cellDataModel andFootViewF:footR];
}



#pragma mark - <内部视图交互事件> -

- (void)clickOnePicWithPicImgView:(HXHomeCellImageView *)picImgView andIndex:(NSInteger)picIndex {
    
    NSInteger count = _cellDataModel.images.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        NSString *url = @"";//[NSString stringWithFormat:@"%@/%@?p=0", [EnvironmentConfigModel sharedEnvironmentConfigModel].env_configs.zimg_download_endpoint, _cellDataModel.images[i]];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
//        photo.imageMd5 = _cellDataModel.images[i];
//        photo.label = _cellDataModel.lable;
        
        if ([url isKindOfClass:[UIImage class]]) {
            photo.url = nil;
            photo.srcImageView.image = (UIImage *)url;
        }
        
        [photos addObject:photo];
        
        photo.srcImageView = picImgView;
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = picIndex; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

///** cell底部功能视图的事件点击 */
- (void)footViewFuncBtnClicked:(HXHomeCellFootViewEventType)footEType {
//
//    if (footEType == HXHomeCellFootViewNeedConfimEventType) {
//        [self confirmMsg];
//    } else if (footEType == HXHomeCellFootViewDeleteMsgEventType) {
//        [self delMsg];
//    } else if (footEType == HXHomeCellFootViewNeedPraiseMsgEventType) {
//        [self praiseMsg];
//    } else if (footEType == HXHomeCellFootViewNoneEventType) {
//        if (_eventCall) {
//            HomeCellEventType cellEType = (NSInteger)footEType;
//            _eventCall(cellEType,_cellDataModel);
//        }
//    }
}
///**
// *  点赞
// */
//- (void)praiseMsg {
//    
//    if (!networkIsReachable()) {
//        //networkNoneTip(); 无网 不需要强弹框
//        return;
//    }
//    
//    ClassmonmentsControl *classmonment = [RightManagement sharedRightManagement].moduleControl.class_monments;
//    FeatureControl *zambia = classmonment.zambia;
//    
//    if (zambia.strategy) {
//        [self controlEventWith:zambia andAc:nil];
//        return;
//    }
//    
//    if ([_cellDataModel.creator_role isEqualToString:@"2"]) {
//        return;
//    }
//    GetClassNewsListInterface *parameter = [[GetClassNewsListInterface alloc]init];
//    parameter.moment_id  = _cellDataModel.moment_id;
//    
//    if (!_cellDataModel.cellContentBox.isClickedPraise) {
//        __weak __typeof(self)weakSelf = self;
//        
//        [ClassNewsBusiness  putClassNewsPraiseWithInterface:parameter success:^(id result) {
//            
//            _cellDataModel.cellContentBox.isClickedPraise = YES;
//            ThumbupsModel *praise = [[ThumbupsModel alloc]init];
//            if (_cellDataModel.thumbups.count > 0) {
//                praise.user_display_name = parameter.user_display_name;
//            } else {
//                praise.user_display_name = parameter.user_display_name;
//            }
//            praise.user_id = [ParentInfoCenter sharedParentInfoCenter].parent_id;
//            _cellDataModel.already_thumbup = @"1";
//            [_cellDataModel.thumbups addObject:praise];
//            
//            // 保存更新的改变的信息
//            NSDictionary *dic = _cellDataModel.mj_keyValues;
//            
//            [[XGFMDBTool sharedFMDBManager] updateDbById:_cellDataModel.moment_id type:_cellDataModel.resource_type position:_cellDataModel.pos WithObject:dic fromTable:KBTC_TABLE_ClASSNEWSMODEL];
//            
//            if (weakSelf.eventCall) {
//                weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//            }
//            
//        } failure:^(NSString *error) {
//            if (weakSelf.eventCall) {
//                weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//            }
//        }];
//        
//    } else if (_cellDataModel.already_thumbup.intValue ==1) {
//        [MBProgressHUD showMessageWithNoneIcon:@"您已经点过赞了哦" delay:0.75 toView:[[ChooseViewController getCurrentViewController] view]];
//    }
//}
///**
// *  删除消息
// */
//- (void)delMsg {
//    
//    if (self.eventCall) {
//        self.eventCall(eHomeCellDeleteMsgEventType,_cellDataModel);
//    }
//}
///**
// *  点击确认
// */
//- (void)confirmMsg {
//    
//    ClassmonmentsControl *classmonment = [RightManagement sharedRightManagement].moduleControl.class_monments;
//    FeatureControl *notice = classmonment.notice_receipt;
//    if (notice.strategy) {
//        [self controlEventWith:notice andAc:nil];
//        return;
//    }
//    PostNoticeReadInterface *interface = [[PostNoticeReadInterface alloc]init];
//    interface.moment_id = _cellDataModel.moment_id;
//    interface.creator_id = _cellDataModel.creator_id;
//    
//    __weak __typeof(self)weakSelf = self;
//    [ClassNewsBusiness postNoticeReadWithInterface:interface success:^(id result) {
//        
//        _cellDataModel.already_read = @"1";
//        if (weakSelf.eventCall) {
//            weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//        }
//        
//    } failure:^(NSString *error) {
//        if (weakSelf.eventCall) {
//            weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//        }
//    }];
//}
///**
// *  发送失败后，重新发送
// */
//- (void)resendMsg {
//    
//    if (!networkIsReachable()) {
//        return;
//    }
//    // 获取对应的请求接口
//    SendClassNewsInterface *interface = [DBBusinessUtil getSendClassnewsFromDBByCreateTime:_cellDataModel.created_at];
//    if (!interface) return;
//    _cellDataModel.retrySending = YES;
//    
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 发送请求
//        __weak typeof(self) weakSelf = self;
//        [ClassNewsBusiness sendClassNewsWithInterface:interface success:^(SendClassNewsModel *result) {
//            // 删除重新发布成功的请求
//            [DBBusinessUtil deleteSendClassnewsInterfaceFromDBByCreateTime:interface.creat_at];
//            //Log(@"删除重新发布的请求成功!%@", interface.creat_at);
//            _cellDataModel.retry = NO;
//            _cellDataModel.retrySending = NO;
//            _cellDataModel.moment_id = result.moment_id;
//            if (weakSelf.eventCall) {
//                weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//            }
//        } failure:^(NSString *error) {
//            _cellDataModel.retry = YES;
//            _cellDataModel.retrySending = NO;
//            
//            if (weakSelf.eventCall) {
//                weakSelf.eventCall(eHomeCellNoneEventType,_cellDataModel);
//            }
//        }];
//    });
//}
//
//- (void)controlEventWith:(FeatureControl *)z andAc:(id)o {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    if ([[ChooseViewController getCurrentViewController] isKindOfClass:NSClassFromString(@"FirstViewController")]) {
//        if ([[ChooseViewController getCurrentViewController] respondsToSelector:@selector(handleFeatureActionControl:defautlAction:)]) {
//            [[ChooseViewController getCurrentViewController] performSelector:@selector(handleFeatureActionControl:defautlAction:) withObject:z withObject:o];
//        }
//    }
//#pragma clang diagnostic pop
//    
//}

#pragma mark - <继承父类> -

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
