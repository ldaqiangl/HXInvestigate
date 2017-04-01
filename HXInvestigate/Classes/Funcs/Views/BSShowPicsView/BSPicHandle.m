//
//  BSPicHandle.m
//  YiJianDoctor
//
//  Created by YJHou on 15/12/28.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import "BSPicHandle.h"

@interface BSPicHandle ()

@property (nonatomic, strong) SDImageCache *sdImageCache;

@end

@implementation BSPicHandle
bs_singleton_implementation(BSPicHandle);

- (instancetype)init {
    if (self = [super init]) {
        self.sdImageCache = [[SDImageCache alloc] initWithNamespace:@"BSShowPic"];
    }
    return self;
}


- (NSString *)storeOneImageWith_BSTool:(NSObject *)imageObj {
    NSString *imgName;
    if (imageObj) {}
    
    /*
     {
     
     if ([imageObj isKindOfClass:[UIImage class]]) {
     imgName = [NSString stringWithFormat:@"%@.jpg",[self getUUIDString_BS]];
     
     UIImage *pic = (UIImage *)imageObj;
     
     //存储图片前对图片进行处理
     //1.压
     //image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.5)];
     
     //2.缩
     
     //3.纠正方向
     pic = [self imageFixOrientation_BS:pic];
     
     //            [self.sdImageCache storeImage:pic forKey:imgName];
     } else if ([imageObj isKindOfClass:[NSString class]]&&[[NSString stringWithFormat:@"%@",imageObj] hasPrefix:@"http"]) {
     NSString *imgUrl = (NSString *)imageObj;
     imgName = [imgUrl mutableCopy];
     [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
     
     } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
     
     //                [self.sdImageCache storeImage:image forKey:imgName];
     if (self.reloadShowPicsView) {
     self.reloadShowPicsView();
     }
     }];
     
     }
     }
     */
    return imgName;
}

- (NSArray *)storeImageWith_BSTool:(NSArray *)images {
    
    NSMutableArray *imageNames = [NSMutableArray array];
    
    for (NSObject *imgObj in images) {
        [imageNames addObject:[self storeOneImageWith_BSTool:imgObj]];
    }
    
    return imageNames;
}


- (UIImage *)obtainKnownOnePicWith_BSTool:(NSString *)picName {
    return [self.sdImageCache imageFromDiskCacheForKey:picName];
}


- (NSArray *)obtainKnownPicsWith_BSTool:(NSArray *)picNames {
    
    NSMutableArray *picsArr = [NSMutableArray array];
    
    for (NSString *picName in picNames) {
        UIImage *pic = [self.sdImageCache imageFromDiskCacheForKey:picName];
        [picsArr addObject:pic];
    }
    
    return picsArr;
}


- (BOOL)clearDesignatedPicsWith:(NSArray *)picNames {
    
    __block BOOL isClearCom = NO;
    if (picNames) {
        for (NSString *picName in picNames) {
            [self.sdImageCache removeImageForKey:picName withCompletion:^{
                isClearCom = YES;
            }];
        }
    } else {
        [self.sdImageCache clearDiskOnCompletion:^{
            isClearCom = YES;
        }];
    }
    
    return isClearCom;
}


//随机生成图片名称
- (NSString *)getUUIDString_BS {
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    
    return uuidString;
}


//缩
- (UIImage *)compressImageToTargetSizeEqualRatioWith_BS:(UIImage *)sourceImage andTargetSize:(CGSize)targetSize {
    
    
    
    return sourceImage;
}


//正中裁剪
- (UIImage *)clipImageCenterWith_BS:(UIImage *)sourceImage andOrigalRect:(CGRect)bound {
    CGSize targetSize = bound.size;
    CGFloat whS = targetSize.width/targetSize.height;
    
    CGFloat newW;
    CGFloat newH;
    
    if (sourceImage.size.width>sourceImage.size.height) {
        newH = sourceImage.size.height;
        newW = sourceImage.size.height * whS;
    } else {
        newW = sourceImage.size.width;
        newH = sourceImage.size.width / whS;
    }
    
    CGFloat x = (sourceImage.size.width-newW)*0.5;
    CGFloat y = (sourceImage.size.height-newH)*0.5;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(sourceImage.CGImage, CGRectMake(x, y, newW, newH));
    UIImage *cropedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropedImage;

}



//纠正图片方向
- (UIImage *)imageFixOrientation_BS:(UIImage *)srcImg {
    
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end





@implementation BSPicture

@end
