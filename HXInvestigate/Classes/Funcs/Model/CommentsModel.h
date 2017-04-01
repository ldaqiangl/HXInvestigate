//
//  CommentsModel.h
//  HXInvestigate
//
//  Created by 董富强 on 16/9/8.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject


@property (nonatomic,assign)NSInteger comment_id;//评论Id

@property (nonatomic,assign)NSInteger user_id;//评论者Id

@property (nonatomic,retain)NSString *user_display_name;//评论者昵称

@property (nonatomic,assign)NSInteger reply_to_user_id;//回复用户Id

@property (nonatomic,retain)NSString *content;//评论内容

@property (nonatomic,retain)NSString *created_at;//评论时间

@property(nonatomic) float height;

@end
