//
//  XZLTextView.h
//  XinZhiLi
//
//  Created by 钟振华 on 16/12/18.
//  Copyright © 2016年 xinzhili. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MaxTextViewHeight 40 //限制文字输入的高度

@interface XZLTextView : UIView
//------ 发送文本 -----//
@property (nonatomic,copy) void (^XZLTextViewBlock)(NSString *text);
//------  设置占位符 ------//
- (void)setPlaceholderText:(NSString *)text;

@end
