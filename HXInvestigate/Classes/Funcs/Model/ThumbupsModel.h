//
//  ThumbupsModel.h
//  HXInvestigate
//
//  Created by 董富强 on 16/9/8.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThumbupsModel : NSObject

@property (nonatomic,retain)NSString *thumbup_id;//点赞Id

@property (nonatomic,retain)NSString *user_id;//点赞者Id

@property (nonatomic,retain)NSString *user_display_name;//点赞者名字

@property (nonatomic,retain)NSString *user_avatar;//点赞者头像

@property (nonatomic,retain)NSString *created_at;//点赞时间

@property (nonatomic,assign)BOOL  isPraise;

@end
