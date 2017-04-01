//
//  HXHomeTool.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/18.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXHomeHeader.h"

//---------------------------- 分割线 ----------------------------

/**
 *  DAQIANG-CUSTOME:自定义标签视图的布局信息解析【C函数】
 *
 *  @param boxString 需要解析的字符串#放入合法的参数#
 *
 *  @return 返回包装布局信息的结构体
 */
HXTagRect HXTagRectFromString(NSString *boxString);
/**
 *  DAQIANG-CUSTOME:自定义标签视图布局信息转化为字符串【C函数】
 *
 *  @param tagRect
 *
 *  @return 转化字符串结果
 */
NSString* HXStringFromHXTagRect(HXTagRect tagRect);
/**
 *  DAQIANG-CUSTOME:标签视图布局信息默认值
 *
 *  @return 字符串结果
 */
NSString* HXTagRectZero();

//---------------------------- 分割线 ----------------------------

/**
 *  DAQIANG-CUSTOME:自定义cell头部视图的布局信息解析【C函数】
 *
 *  @param boxString 需要解析的字符串#放入合法的参数#
 *
 *  @return 返回包装布局信息的结构体
 */
HXHomeCellHeadRect HXHomeCellHeadRectFromString(NSString *boxString);
/**
 *  DAQIANG-CUSTOME:自定义头部视图布局信息转化为字符串【C函数】
 *
 *  @param tagRect
 *
 *  @return 转化字符串结果
 */
NSString* HXStringFromHXHomeCellHeadRect(HXHomeCellHeadRect headRect);
/**
 *  DAQIANG-CUSTOME:头部视图布局信息默认值
 *
 *  @return 字符串结果
 */
NSString* HXHeadRectZero();

//---------------------------- 分割线 ----------------------------

/**
 *  DAQIANG-CUSTOME:自定义文本视图的布局信息解析【C函数】
 *
 *  @param boxString 需要解析的字符串#放入合法的参数#
 *
 *  @return 返回包装布局信息的结构体
 */
HXHomeCellTextRect HXHomeCellTextRectFromString(NSString *boxString);
/**
 *  DAQIANG-CUSTOME:自定义文本视图布局信息转化为字符串【C函数】
 *
 *  @param tagRect
 *
 *  @return 转化字符串结果
 */
NSString* HXStringFromHXHomeCellTextRect(HXHomeCellTextRect textRect);
/**
 *  DAQIANG-CUSTOME:文本视图布局信息默认值
 *
 *  @return 字符串结果
 */
NSString* HXTextRectZero();

//---------------------------- 分割线 ----------------------------

/**
 *  DAQIANG-CUSTOME:自定义媒体（图片、视频）视图的布局信息解析【C函数】
 *
 *  @param boxString 需要解析的字符串#放入合法的参数#
 *
 *  @return 返回包装布局信息的结构体
 */
HXHomeCellMediaRect HXHomeCellMediaRectFromString(NSString *boxString);
/**
 *  DAQIANG-CUSTOME:自定义媒体（图片、视频）视图布局信息转化为字符串【C函数】
 *
 *  @param tagRect
 *
 *  @return 转化字符串结果
 */
NSString* HXStringFromHXHomeCellMediaRect(HXHomeCellMediaRect mediaRect);
/**
 *  DAQIANG-CUSTOME:媒体（图片、视频）视图布局信息默认值
 *
 *  @return 字符串结果
 */
NSString* HXMediaRectZero();

//---------------------------- 分割线 ----------------------------
/**
 *  DAQIANG-CUSTOME:自定义底部功能视图的布局信息解析【C函数】
 *
 *  @param boxString 需要解析的字符串#放入合法的参数#
 *
 *  @return 返回包装布局信息的结构体
 */
HXHomeCellFootRect HXHomeCellFootRectFromString(NSString *boxString);
/**
 *  DAQIANG-CUSTOME:自定义底部功能视图布局信息转化为字符串【C函数】
 *
 *  @param tagRect
 *
 *  @return 转化字符串结果
 */
NSString* HXStringFromHXHomeCellFootRect(HXHomeCellFootRect footRect);
/**
 *  DAQIANG-CUSTOME:底部功能视图布局信息默认值
 *
 *  @return 字符串结果
 */
NSString* HXFootRectZero();



@interface HXHomeTool : NSObject
@end
