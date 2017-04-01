//
//  CTFrameParserConfig.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/23.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (instancetype)init {
    if (self = [super init]) {
        _width = 100.0f;
        _fontSize = 12.0f;
        _lineSpace = 8.0;
        _textColor = RGB(108, 108, 108);
        _limitLineCount = 4;
    }
    return self;
}

@end
