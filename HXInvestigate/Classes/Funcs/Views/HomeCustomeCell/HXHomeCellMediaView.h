//
//  HXHomeCellMediaView.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXHomeCellFootView.h"

@class HXHomeCellImageView;
typedef void (^HomeCellMediaViewEventBlock)(HXHomeCellImageView *picImgView,NSInteger picIndex);

/** >>>>>> cell的多媒体（图片，视频，音频）视图 <<<<<< */

@interface HXHomeCellMediaView : UIView

- (instancetype)initWithCallEvent:(HomeCellMediaViewEventBlock)callBack;

- (void)setupHomeCellMediaViewWithData:(ClassNewsModel *)cellDataModel andMediaR:(HXHomeCellMediaRect)mediaR;
@end


/** >>>>>> 图片集中自定义的UIImageView视图 <<<<<< */

@interface HXHomeCellImageView : UIImageView

- (instancetype)initWithTapBolck:(void(^)(HXHomeCellImageView *imgView))tapBlock;
@end