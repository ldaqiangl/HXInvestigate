//
//  WFTextView.h
//  WFCoretext
//
//  Created by 阿虎 on 14/10/31.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//
/**
 *  CTLine 去画
 *
 */

#import <UIKit/UIKit.h>

@protocol WFCoretextDelegate <NSObject>

- (void)clickWFCoretext:(NSInteger )commentId;

@end

@interface WFTextView : UIView

@property (nonatomic,strong) NSAttributedString *attrEmotionString;
@property (nonatomic,strong) NSArray *emotionNames;
@property (nonatomic,assign) BOOL isDraw;//画
@property (nonatomic,assign) BOOL isFold;//是否折叠
@property (nonatomic,strong) NSMutableArray *attributedData;//属性数据
@property (nonatomic,assign) int textLine;//文字线
@property (nonatomic,retain) NSString *commentId;
@property (nonatomic,assign) id<WFCoretextDelegate>delegate;
@property (nonatomic,assign) CFIndex limitCharIndex;//限制行的最后一个char的index


- (void)setOldString:(NSString *)oldString andNewString:(NSString *)newString;

- (int)getTextLines;

- (float)getTextHeight;

@end
