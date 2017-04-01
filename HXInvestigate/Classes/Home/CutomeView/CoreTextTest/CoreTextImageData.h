//
//  CoreTextImageData.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/24.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int position;

/**
 *  此坐标不是UIKit坐标 而是CoreText坐标系
 */
@property (nonatomic, assign) CGRect imagePosition;


@end
