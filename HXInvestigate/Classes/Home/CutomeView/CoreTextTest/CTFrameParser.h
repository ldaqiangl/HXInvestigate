//
//  CTFrameParser.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/23.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoreTextData.h"

@interface CTFrameParser : NSObject


+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig*)config;

+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config;

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig*)config;

@end
