//
//  HXHomeHeader.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/18.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#ifndef HXHomeHeader_h
#define HXHomeHeader_h

//DAQIANG-ADD

//层层包装 headView中的子视图布局信息
struct HXTagBoxRect {
    /** 标签视图整体Rect */
    CGRect tagViewF;
    /** 标签视图中前缀控件Rect */
    CGRect tagTitleF;
    /** 标签视图中内容控件Rect */
    CGRect tagLabelF;
};
typedef struct HXTagBoxRect HXTagRect;


//---------------------------- 分割线 ----------------------------

//headView的内部视图布局信息
struct HXHomeCellHeadRect {
    /** 头部视图整体Rect */
    CGRect headViewF;
    
    /** 头像Rect */
    CGRect iconF;
    /** 昵称、名称Rect */
    CGRect nameLabelF;
    /** 角色称谓Rect */
    CGRect roleTitleF;
    /** 标签视图Rect */
    HXTagRect tagViewF;
    /** 时间Rect */
    CGRect timeLabelF;
    /** 重发按钮 */
    CGRect resendBtnF;
    
    /** 头部视图高度 */
    CGFloat headViewH;
};
typedef struct HXHomeCellHeadRect HXHomeCellHeadRect;


//---------------------------- 分割线 ----------------------------

/**
 *  textView的内部视图布局信息
 */
struct HXHomeCellTextRect {
    /** 文本视图整体Rect */
    CGRect textViewF;
    
    /** 文本内容Rect */
    CGRect textContentF;
    /** 控制按钮Rect */
    CGRect controlBtnF;
    
    /** 文本视图高度 */
    CGFloat textViewH;
};
typedef struct HXHomeCellTextRect HXHomeCellTextRect;

//---------------------------- 分割线 ----------------------------

//mediaView的内部视图布局信息
struct HXHomeCellMediaRect {
    /** 多媒体视图整体Rect */
    CGRect mediaViewF;
    
    /** 每张图片宽度 */
    CGFloat perPicW;
    /** 每张图片高度 */
    CGFloat perPicH;
    /** 图片之间的间距 */
    CGFloat spaceL;
    
    /** 多媒体视图整体高度 */
    CGFloat mediaViewH;
};
typedef struct HXHomeCellMediaRect HXHomeCellMediaRect;

//---------------------------- 分割线 ----------------------------

//footView的内部视图布局信息
struct HXHomeCellFootRect {
    /** 底部视图整体Rect */
    CGRect footViewF;
    
    /** 确认按钮Rect */
    CGRect sureBtnF;
    /** 删除按钮Rect */
    CGRect delBtnF;
    /** 点赞按钮Rect */
    CGRect praiseBtnF;
    /** 分割线Rect */
    CGRect lineViewF;
    /** 点赞者视图Rect */
    CGRect praiserLF;
    
    /** 多媒体视图整体高度 */
    CGFloat footViewH;
};
typedef struct HXHomeCellFootRect HXHomeCellFootRect;



//DAQIANG

#endif /* HXHomeHeader_h */
