//
//  CoreTextData.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/23.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTFrameParserConfig.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"

@interface CoreTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CTTypesetterRef ctTypeSetter;
@property (nonatomic, assign) CGFloat height;
@property (strong, nonatomic) NSAttributedString *content;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *linkArray;

@end
