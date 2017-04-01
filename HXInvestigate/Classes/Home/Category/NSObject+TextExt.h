//
//  NSObject+TextExt.h
//  HBBForParent
//
//  Created by 董富强 on 16/8/18.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTextResultBox : NSObject

@property (nonatomic, copy) NSAttributedString *textAttrs;
@property (nonatomic, assign) CGSize textSize;

@end

@interface NSObject (TextExt)


- (HXTextResultBox *)getParagraphAttrStrWith_BSExt:(NSString *)content andFont:(UIFont *)font andMaxW:(CGFloat)maxW;

@end
