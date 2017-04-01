//
//  CTDisplayView.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/23.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTFrameParser.h"

@interface CTDisplayView : UIView

@property (nonatomic, strong) CTFrameParserConfig *config;

@property (nonatomic, strong) CoreTextData *data;

@end
