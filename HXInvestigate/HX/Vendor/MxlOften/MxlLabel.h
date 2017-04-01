//
//  MxlLabel.h
//  ParentsMenu
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTAttributedLabel.h"

typedef NS_OPTIONS(NSUInteger, MXLEmojiLabelLinkType) {
    MLEmojiLabelLinkTypeURL = 0,
    MLEmojiLabelLinkTypePhoneNumber,
    MLEmojiLabelLinkTypeEmail,
    MLEmojiLabelLinkTypeAt,
    MLEmojiLabelLinkTypePoundSign,
};

@class MxlLabel;
@protocol MLEmojiLabelDelegate <NSObject>

@optional
- (void)mlEmojiLabel:(MxlLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MXLEmojiLabelLinkType)type;

//- (void)mxlLabel;(MxlLabel*)mxlLabel 
@end

@interface MxlLabel : TTTAttributedLabel<TTTAttributedLabelDelegate>

@property (nonatomic,assign)BOOL  copyEnableAlready;

@property (nonatomic, assign) BOOL disableEmoji; //禁用表情
@property (nonatomic, assign) BOOL disableThreeCommon; //禁用电话，邮箱，连接三者

@property (nonatomic, assign) BOOL isNeedAtAndPoundSign; //是否需要话题和@功能，默认为不需要

@property (nonatomic, copy) NSString *customEmojiRegex; //自定义表情正则
@property (nonatomic, copy) NSString *customEmojiPlistName; //xxxxx.plist 格式

@property (nonatomic, weak) id<MLEmojiLabelDelegate> emojiDelegate; //点击连接的代理方法

@property (nonatomic, copy) NSString *emojiText; //设置处理文字
@property (nonatomic, strong) NSRegularExpression *customEmojiRegularExpression;
@property (nonatomic, strong) NSDictionary *customEmojiDictionary;

@property (nonatomic,assign) BOOL isFold;//是否折叠

- (int)getTextLines:(NSString *)string;

//- (float)getTextHeight:(NSString*)string;

-(void)registerCopyAction;

@end
