//
//  CoreTextLinkData.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/24.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSRange range;

@end
