//
//  AddZSViewController.m
//  YiJianDoctor
//
//  Created by YJHou on 15/12/28.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO:以后分类 删除功能类型和不带删除功能类型
typedef NS_OPTIONS(NSInteger, BSShowPhotosViewType) {
    BSShowPhotosViewCanDeletePicType = 1,
    BSShowPhotosViewNoDeletePicType  = 1 << 1,
};

@class BSShowPhotosView;
/** 数据源代理 */
@protocol BSShowPhotosViewDataSource <NSObject>

@optional;

//1.询问要添加的图片
//(1)单张添加
- (UIImage *)showPhotosView:(BSShowPhotosView *)showPhotosView imageForIndex:(NSInteger)index;
//(2)多张添加(目前只可以是UIImage 和 http的图片链接地址混合数组返回)
- (NSArray *)showPhotosView:(BSShowPhotosView *)showPhotosView imagesForindexArr:(NSArray *)indexArray;

@end

/** 事件代理 */
@protocol BSShowPhotosViewDelegate <NSObject>
@optional;
/** 图片添加完成 */
- (void)showPhotosViewPicDidAdd:(BSShowPhotosView *)showPhotoView andCurrentPics:(NSArray *)picNames;
/** 添加图片按钮已经点击 */
- (void)showPhotosViewAddDidSelected:(BSShowPhotosView *)showPhotoView andCurrentPics:(NSArray *)picNames;
/** 删除图片 */
- (void)showPhotosViewDeletePics:(BSShowPhotosView *)showPhotoView andRemainingPics:(NSArray *)picNames;
/** 点击图片查看大图 */
- (void)showPhotosViewScanPics:(BSShowPhotosView *)showPhotoView withAllPicNames:(NSArray *)picNames andClickedIndex:(NSInteger)picIndex;
/** 到达showPhotosView图片数量上限 */
- (void)showPhotosView:(BSShowPhotosView *)showPhotoView withLimitMaxCount:(NSInteger)maxCount andCurrentPicNames:(NSArray *)picNames;

@end


#import "BSPicHandle.h"

@interface BSShowPhotosView : UIView

@property (nonatomic, assign) id<BSShowPhotosViewDataSource> dataSource;
@property (nonatomic, assign) id<BSShowPhotosViewDelegate> delegate;

/**
 *  预处理 设置删除按钮和添加按钮
 *  @param delImage 删除按钮素材名称
 *  @param addImage 添加按钮素材名称
 *  @param maxCount 容纳图片数量上限
 */
- (void)preparePhotoViewWithDelPic:(NSString *)delImage andAddPic:(NSString *)addImage andMaxPicCount:(NSInteger)maxCount;
/**
 *  外界添加完图片后 进行刷新
 */
- (void)reloadShowPhotosView;
/**
 *  清除图片以及文件系统的图片文件(在控制器的dealloc里进行调用)
 */
- (void)cleanAllPicsAndPicCache;

@end


