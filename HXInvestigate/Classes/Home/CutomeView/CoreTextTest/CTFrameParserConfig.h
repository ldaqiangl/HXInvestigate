//
//  CTFrameParserConfig.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/23.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreText/CoreText.h>

/**
 *  用于配置绘制的参数,例如：文字颜色、大小、行间距等
 */
@interface CTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSInteger limitLineCount;
@property (nonatomic, assign) BOOL isOpen;

@end
