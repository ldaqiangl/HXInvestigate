//
//  VideoModel.h
//  HXInvestigate
//
//  Created by 董富强 on 16/9/8.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

/** 视频预览图 */
@property (nonatomic, copy) NSString *cover_url;
/** 地址 */
@property (nonatomic, copy) NSString *video_url;


@end
