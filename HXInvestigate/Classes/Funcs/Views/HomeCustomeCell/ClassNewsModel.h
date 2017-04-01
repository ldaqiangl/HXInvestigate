//
//  ClassNewsModel.h
//  ParentsMenu
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "CommentsModel.h"
#import "ThumbupsModel.h"
#import "VideoModel.h"

#import "ConstHead.h"
#import "HXHomeTool.h"


//DAQIANG-ADD
//包装需要处理的文本数据
@interface HXHomeCellContentBox : NSObject

/** 是否隐藏显示头像 */
@property (nonatomic, assign) BOOL isHiddenIcon;

/** 角色显示文本 */
@property (nonatomic, copy) NSString *roleTitle;
/** 时间显示的文本 */
@property (nonatomic, copy) NSString *time;

/** 标签前缀，默认显示：“通知” */
@property (nonatomic, copy) NSString *labelPre;
/** 标签显示内容 */
@property (nonatomic, copy) NSString *labelContent;
/** 标签显示的内容颜色 */
@property (nonatomic, copy) NSString *labelColor;

/** 判断是否需要重发 */
@property (nonatomic, assign, getter = isResend) BOOL resend;
/** 判断是否正在重发 */
@property (nonatomic, assign, getter = isRetrySending) BOOL retrySending;
/** 发送状态 显示文本内容 */
@property (nonatomic, copy) NSString *resendTipContent;

/** 是否显示“全完（收起）”控制按钮 */
@property (nonatomic, assign) BOOL isHiddenControlBtn;
/** 是否是打开（全文）状态:YES-全文，NO-收起 */
@property (nonatomic, assign) BOOL isOpen;
/** 文本视图实际显示的内容 */
@property (nonatomic, copy) NSString *textContent;
/** 文本内部特殊处理过的数据（需要高亮和链接事件的文字：如：电话、邮箱等） */
@property (nonatomic, strong) NSMutableArray *highLightLinkDataArr;

/** 多媒体视图中图片缩略图全网址（http://...）数组,存字符串 */
//@property (nonatomic, strong) NSMutableArray *thumbnailPics;
//@property (nonatomic, strong) NSMutableArray *originalPics;
/** 是否调用过本条数据模型的下载图片后计算的操作，保证每个数据模型的图片下载计算只有效计算一次就够
 YES：调用过startCalculateSelf，之后此模型就不用再调用图片下载的异步计算方法了;
 NO:没有调用过startCalculateSelf，需要进行图片下载后计算的异步操作控件布局的计算
 */
@property (nonatomic, assign) BOOL isFinishedPicCal;

/** 是否隐藏确认按钮 */
@property (nonatomic, assign) BOOL isHiddenSureBtn;
/** 确认按钮是否是选中状态 */
@property (nonatomic, assign) BOOL isSelectedSureBtn;
/** 是否隐藏删除按钮 */
@property (nonatomic, assign) BOOL isHiddenDelBtn;
/** 是否点过赞（YES：点过，NO：没有点击过） */
@property (nonatomic, assign) BOOL isClickedPraise;


@property (nonatomic, copy) NSString *praisePeoplesStr;


@property (nonatomic, assign) CGFloat cellH;
@end
//DAQIANG

@protocol ImageHeightDelegate <NSObject>

-(void)finishedImageHeight;

@end

@interface ClassNewsModel : NSObject

@property (nonatomic,retain)NSString *moment_id;//精彩瞬间的Id

@property (nonatomic,retain)NSString *pos;//服务器上消息的position

@property (nonatomic,retain)NSString *lable;//精彩瞬间label

@property (nonatomic,retain)NSString *content;//精彩瞬间正文

@property (nonatomic,retain)NSArray *images;//图片URL

@property (nonatomic,retain)VideoModel *video;//视频

@property (nonatomic,retain)NSString *creator_id;//创建者ID

@property (nonatomic,retain)NSString *creator_display_name;//创建者昵称

@property (nonatomic,retain)NSString *creator_avatar;//创建者头像图片URL

@property (nonatomic,retain)NSString *creator_role;//用户类型  是家长 还是老师

@property (nonatomic,retain)NSString *created_at;//创建时间

/** 全校可见(0:不可见/1:可见) */
@property (nonatomic, copy) NSString *is_for_school;
/** 全班可见(0:不可见/1:可见) */
@property (nonatomic, copy) NSString *is_for_class;

@property (nonatomic,retain)NSMutableArray *thumbups;//点赞数组

@property  (nonatomic,retain)NSArray *comments;//评论数组

@property (nonatomic,retain)NSArray *gifts;//礼物数组

@property (nonatomic,retain)NSString *is_owner;//该条信息是否由本人创建

@property (nonatomic,retain)NSString *already_thumbup;//当前用户是否点过赞

@property (nonatomic,retain)NSNumber *already_sent_gift;//当前用户是否已经送礼

/** 家长端判断当前用户是已读确认(0:未确认;1:已确认) */
@property (nonatomic, copy) NSString *already_read;
/** 已读数量 */
@property (nonatomic, copy) NSString *readers_count;
/** 未读数量 */
@property (nonatomic, copy) NSString *unreaders_count;

@property (nonatomic,retain)NSString *resource_type; //资源类型
@property (nonatomic,retain)NSDictionary *relation_obj;

//DAQIANG-ADD
@property (nonatomic, copy) NSString *title;//#目前行为记录,内容资源推荐使用(V2.0)
@property (nonatomic, copy) NSString *school_name;//学校名称(v2.0)

@property (nonatomic, strong) HXHomeCellContentBox *cellContentBox;
@property (nonatomic, copy) NSString *headViewF;
@property (nonatomic, copy) NSString *textViewF;
@property (nonatomic, copy) NSString *mediaViewF;
@property (nonatomic, copy) NSString *footViewF;
//DAQINAG

@property (nonatomic,assign)id<ImageHeightDelegate>mydelegate;

#pragma mark 自定义属性
/** 判断是否需要重发 */
@property (nonatomic, assign, getter = isRetry) BOOL retry;
/** 判断是否正在重发 */
@property (nonatomic, assign, getter = isRetrySending) BOOL retrySending;

@property (nonatomic,assign)CGFloat contentFoldHeight; //折叠说说高度

@property (nonatomic,assign)CGFloat contentUnFoldHeight;//展开说说高度

@property (nonatomic,assign) BOOL  foldOrNot;//是否折叠

@property (nonatomic,assign) BOOL islessLimit;//是否小于最低限制 宏定义最低限制是 limitline

@property (nonatomic,strong) NSMutableArray *attributedData;//YMTextView附带的点击区域数组
@property (nonatomic,strong) NSMutableArray *attributedDataWF;//WFTextView附带的点击区域数组

@property (nonatomic,strong) NSString       *showShuoShuo;//说说部分
@property (nonatomic,strong) NSString       *completionShuoshuo;//说说部分（处理后）


@property (nonatomic,retain)CommentsModel *mycomment;
@property (nonatomic,retain)ThumbupsModel *mypraise;

@property (nonatomic,strong) NSMutableArray *completionReplySource;//回复内容数据源（处理）

@property (nonatomic,assign) float           showImageHeight;//展示图片的高度


@property (nonatomic,strong) NSMutableArray *defineAttrData;//自行添加 元素为每条回复中的自行添加的range组成的数组 如：第一条回复有（0，2）和（5，2） 第二条为（0，2）。。。。

@property (nonatomic,retain)NSString *approval_at;//审核时间

@property (nonatomic,retain)NSString *status;   //审核状态


//DAQIANG-ADD
/**
 *  开始计算自己
 *
 *  @param calComBlock 计算完毕，回调给调用者进行其他操作
 */
- (void)startCalculateSelf;
//DAQIANG



/**
 *  计算高度
 *
 *  @param sizeWidth view 宽度
 *
 *  @return 返回高度
 */
- (float)calculateReplyHeightWithWidth:(float)sizeWidth;

/**
 *  计算折叠还是展开的说说的高度
 *
 *  @param sizeWidth 宽度
 *  @param isUnfold  展开与否
 *
 *  @return 高度
 */
- (float)calculateShuoshuoHeightWithWidth:(float)sizeWidth withUnFoldState:(BOOL)isUnfold;

- (float)calculateShowImageHeight:(id)image;

///**
// *  计算 点赞的高度
// *
// *  @param sizeWidth 宽度
// *
// *  @return 高度
// */
//- (float)calculatePraiseHeightWithWidth:(float)sizeWidth;
//- (float)calculatePraiseHeight;
@end
