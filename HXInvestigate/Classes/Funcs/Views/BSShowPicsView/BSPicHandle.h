//
//  BSPicHandle.h
//  YiJianDoctor
//
//  Created by YJHou on 15/12/28.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>
// @interface
#define bs_singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define bs_singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}


#import <SDWebImage/SDImageCache.h>
#import "SDWebImageDownloader.h"

@interface BSPicHandle : NSObject
bs_singleton_interface(BSPicHandle);
@property (nonatomic, copy) void(^reloadShowPicsView)();

/**
 *  存储单张图片到文件系统
 *
 *  @param image one pic
 *
 *  @return one image name
 */
- (NSString *)storeOneImageWith_BSTool:(NSObject *)imageObj;

/**
 *  存储图片数组到文件系统
 *
 *  @param images 图片的集合【图片数组】
 *
 *  @return 图片的名称数组
 */
- (NSArray *)storeImageWith_BSTool:(NSArray *)images;


/**
 *  根据名称获取单张图片
 *
 *  @param picName 图片名称
 *
 *  @return 图片
 */
- (UIImage *)obtainKnownOnePicWith_BSTool:(NSString *)picName;


/**
 *  已知图片名称，获取到相应的图片（数组）
 *
 *  @param picNames 图片名称数组
 *
 *  @return 图片二进制（NSData）
 */
- (NSArray *)obtainKnownPicsWith_BSTool:(NSArray *)picNames;


/**
 *  根据图片名称，从文件系统清除指定的的图片
 *
 *  @param picNames 图片名称 (nil为全部清空)
 *
 *  @return 是否清除成功
 */
- (BOOL)clearDesignatedPicsWith:(NSArray *)picNames;


/**
 *  按照目标尺寸等比压缩相应的图片
 *
 *  @param sourceImage 原图
 *  @param targetSize  目标尺寸
 *
 *  @return 压缩完成的图片
 */
- (UIImage *)compressImageToTargetSizeEqualRatioWith_BS:(UIImage *)sourceImage andTargetSize:(CGSize)targetSize;


/**
 *  从原图正中裁剪出缩略图
 *
 *  @param sourceImage 原图
 *  @param targetSize  原图缩放的尺寸
 *
 *  @return 缩略图
 */
- (UIImage *)clipImageCenterWith_BS:(UIImage *)sourceImage andOrigalRect:(CGRect)bound;
@end



//暂时不用
@interface BSPicture : NSObject

@property (nonatomic, copy) NSString *bsPicName;
@property (nonatomic, strong) UIImage *bsPic;

@property (nonatomic, assign) CGSize bsPicSize;

@end