//
//  NSObject+TextExt.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/18.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "NSObject+TextExt.h"

@implementation HXTextResultBox

@end


@implementation NSObject (TextExt)

- (HXTextResultBox *)getParagraphAttrStrWith_BSExt:(NSString *)content andFont:(UIFont *)font andMaxW:(CGFloat)maxW {
    
    NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrapgStyle setLineSpacing:5];
    
    NSMutableAttributedString *mutableAttrs = [[NSMutableAttributedString alloc] initWithString:content];
    [mutableAttrs addAttribute:NSKernAttributeName value:@1 range:NSMakeRange(0, content.length)];
    [mutableAttrs addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, content.length)];
    [mutableAttrs addAttribute:NSParagraphStyleAttributeName value:paragrapgStyle range:NSMakeRange(0, content.length)];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(maxW, 0) options:options attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrapgStyle} context:nil].size;
    
    HXTextResultBox *box = [[HXTextResultBox alloc] init];
    box.textAttrs = mutableAttrs;
    box.textSize = contentSize;
    
    return box;
}

@end
