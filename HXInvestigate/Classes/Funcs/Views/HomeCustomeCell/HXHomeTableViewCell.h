//
//  HXHomeTableViewCell.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXHomeCellHeadView.h"

/** cell里面事件响应类型 */
typedef NS_OPTIONS(NSInteger, HomeCellEventType) {
    eHomeCellNoneEventType = 0,//无任何事件
    eHomeCellHeadIconClickedType = 11,//点击头像事件类型
    eHomeCellTextDisplayControlType = 22,//文本全文（或收起）事件触发类型
    eHomeCellNeedConfimEventType = 41,//确认事件（还没有确认，需要确认）
    eHomeCellHadConfirmEventType = 42,//已经确认了
    eHomeCellDeleteMsgEventType = 43,//删除事件
    eHomeCellNeedPraiseMsgEventType = 44,//点赞事件（还没有点赞，需要点赞）
    eHomeCellHadPraisedMsgEventType = 45,//已经点赞过了
};
/** cell里面各种事件响应回调 */
typedef void (^HXHomeCellEventCallBlock)(HomeCellEventType eventType,ClassNewsModel *cellData);



@interface HXHomeTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *name;

@property (nonatomic, weak) HXHomeCellHeadView *headView;//头部视图
@property (nonatomic, weak) HXHomeCellTextView *textContentView;//文本内容视图
@property (nonatomic, weak) HXHomeCellMediaView *mediaView;//媒体视图（图片、视频等）
@property (nonatomic, weak) HXHomeCellFootView *footFuncView;//尾部功能视图

@property (nonatomic, strong) ClassNewsModel *cellDataModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andEventCall:(HXHomeCellEventCallBlock)eventCallBlock;

/**
 *  用数据模型 设置homeCell
 *
 *  @param homeCellDataModel cell对应的数据模型
 */
- (void)setupHomeTableViewCellWithData:(ClassNewsModel *)cellDataModel;

@end

