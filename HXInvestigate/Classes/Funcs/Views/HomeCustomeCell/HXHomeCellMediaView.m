//
//  HXHomeCellMediaView.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/16.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "HXHomeCellMediaView.h"
//#import "SendClassNewsInterface.h"

@interface HXHomeCellMediaView ()

@property (nonatomic, strong) NSMutableArray *subImageViewsArr;
@property (nonatomic, copy) HomeCellMediaViewEventBlock clickPicCom;
@end

@implementation HXHomeCellMediaView

- (instancetype)initWithCallEvent:(HomeCellMediaViewEventBlock)callBack {
    if (self = [super init]) {
        
        self.clickPicCom = callBack;
        
        __weak __typeof(self)weakSelf = self;
        self.subImageViewsArr = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            
            HXHomeCellImageView *picImageView = [[HXHomeCellImageView alloc] initWithTapBolck:^(HXHomeCellImageView *imgView) {
                [weakSelf picClickedWith:imgView];
            }];
            [self.subImageViewsArr addObject:picImageView];
        }
        
    }
    return self;
}

- (void)setupHomeCellMediaViewWithData:(ClassNewsModel *)cellDataModel andMediaR:(HXHomeCellMediaRect)mediaR {
    
    for (HXHomeCellImageView *subPicView in self.subImageViewsArr) {
        subPicView.image = nil;
        subPicView.frame = CGRectZero;
        subPicView.hidden = YES;
    }
    
    //只有完成对图片的异步处理（下载和计算）之后才能进行 图片加载和显示
    if (cellDataModel.cellContentBox.isFinishedPicCal) {
        
        NSArray *thumbanilPics = cellDataModel.images;
        
        CGFloat space = mediaR.spaceL;
        CGFloat picW = mediaR.perPicW, picH = mediaR.perPicH;
        
        int col = 0, row = 0, totalCol = 3;
        
        if (thumbanilPics.count == 2 || thumbanilPics.count == 4) {
            totalCol = 2;
        }
        
        for (int i = 0; i < thumbanilPics.count; i++) {
            
            row = i / totalCol;
            col = i % totalCol;
            
            if (thumbanilPics.count <= self.subImageViewsArr.count) {
                
                id imageObj = thumbanilPics[i];
                
                HXHomeCellImageView *picImgView = [self.subImageViewsArr objectAtIndex:i];
                
                if ([imageObj isKindOfClass:[NSObject class]]) {
                    
                    NSArray *imageArray = @[];//LLGetPictureFromCachePathName([(SendCLassNewsImageModel *)imageObj imagePath]);
                    UIImage *imagePic = [imageArray firstObject];
                    picImgView.clipsToBounds = YES;
                    picImgView.contentMode = UIViewContentModeScaleAspectFill;
                    
                    picImgView.image = imagePic;
                    
                } else if ([imageObj isKindOfClass:[NSString class]]) {
                    
                    [picImgView sd_setImageWithURL:[NSURL URLWithString:[self getThumbStringWith:imageObj andPicSize:CGSizeMake(picW, picH)]] placeholderImage:nil];
                }
                picImgView.frame = CGRectMake((picW+space)*col,(picH+space)*row, picW, picH);
                picImgView.hidden = NO;
                [self addSubview:picImgView];
            }
        }
    
    }

        
}

- (void)picClickedWith:(HXHomeCellImageView *)imageView {
    
    if (self.clickPicCom) {
        self.clickPicCom(imageView,[self.subImageViewsArr indexOfObject:imageView]);
    }
    
}

- (NSString *)getThumbStringWith:(NSString *)imageMD5 andPicSize:(CGSize)picSize {
    
    //NSURL *samallImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?p=1",[EnvironmentConfigModel sharedEnvironmentConfigModel].env_configs.zimg_download_endpoint, image]];
    NSString *thumbnailImgUrl = @"";//[NSString stringWithFormat:@"%@/%@?w=%f&h=%f&p=1", [EnvironmentConfigModel sharedEnvironmentConfigModel].env_configs.zimg_download_endpoint, imageMD5, picSize.width *1.5, picSize.height *1.5];
    
    return thumbnailImgUrl;
}

- (NSString *)getOriginaleStringWith:(NSString *)imageMD5 {
    
    NSString *originalImgUrl = @"";//[NSString stringWithFormat:@"%@/%@?p=0", [EnvironmentConfigModel sharedEnvironmentConfigModel].env_configs.zimg_download_endpoint, imageMD5];

    return originalImgUrl;
}


@end

//--------------------------- 分割线 ---------------------------

@interface HXHomeCellImageView ()
@property (nonatomic, copy) void(^tapBlock)(HXHomeCellImageView *imgView);
@end

@implementation HXHomeCellImageView

- (instancetype)initWithTapBolck:(void(^)(HXHomeCellImageView *imgView))tapBlock {
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        
        self.tapBlock = tapBlock;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tapEvent:(HXHomeCellImageView *)cellImgView {
    
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

@end