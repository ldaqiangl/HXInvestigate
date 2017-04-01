//
//  HXHomeTool.m
//  HBBForParent
//
//  Created by 董富强 on 16/8/18.
//  Copyright © 2016年 KBTC. All rights reserved.
//

#import "HXHomeTool.h"

#define OneLevelTag @"_"
#define TwoLevelTag @"$"

//---------------------------- 分割线 ----------------------------

HXTagRect HXTagRectFromString(NSString *boxString) {
    NSString *subBox = [boxString substringWithRange:NSMakeRange(1, boxString.length-2)];
    NSArray *subBoxArr = [subBox componentsSeparatedByString:TwoLevelTag];
    
    HXTagRect box;
    box.tagViewF = CGRectFromString([subBoxArr firstObject]);
    box.tagTitleF = CGRectFromString(subBoxArr[1]);
    box.tagLabelF = CGRectFromString([subBoxArr lastObject]);
    return box;
}
NSString* HXStringFromHXTagRect(HXTagRect tagRect) {
    return [NSString stringWithFormat:@"(%@%@%@%@%@)",
            NSStringFromCGRect(tagRect.tagViewF),TwoLevelTag,
            NSStringFromCGRect(tagRect.tagTitleF),TwoLevelTag,
            NSStringFromCGRect(tagRect.tagLabelF)];
}
NSString* HXTagRectZero() {
    
    HXTagRect tagR;
    tagR.tagLabelF = tagR.tagTitleF = tagR.tagViewF = CGRectZero;
    return HXStringFromHXTagRect(tagR);
}

//---------------------------- 分割线 ----------------------------

HXHomeCellHeadRect HXHomeCellHeadRectFromString(NSString *boxString) {
    
    NSString *subBox = [boxString substringWithRange:NSMakeRange(1, boxString.length-2)];
    NSArray *subBoxArr = [subBox componentsSeparatedByString:OneLevelTag];
    
    HXHomeCellHeadRect box;
    
    box.headViewF = CGRectFromString([subBoxArr firstObject]);
    box.iconF = CGRectFromString(subBoxArr[1]);
    box.nameLabelF = CGRectFromString(subBoxArr[2]);
    box.roleTitleF = CGRectFromString(subBoxArr[3]);
    box.tagViewF = HXTagRectFromString(subBoxArr[4]);
    box.timeLabelF = CGRectFromString(subBoxArr[5]);
    box.resendBtnF = CGRectFromString(subBoxArr[6]);
    box.headViewH = [[subBoxArr lastObject] floatValue];
    
    return box;
}
NSString* HXStringFromHXHomeCellHeadRect(HXHomeCellHeadRect headRect) {
    return [NSString stringWithFormat:@"(%@%@%@%@%@%@%@%@%@%@%@%@%@%@%f)",
            NSStringFromCGRect(headRect.headViewF),OneLevelTag,
            NSStringFromCGRect(headRect.iconF),OneLevelTag,
            NSStringFromCGRect(headRect.nameLabelF),OneLevelTag,
            NSStringFromCGRect(headRect.roleTitleF),OneLevelTag,
            HXStringFromHXTagRect(headRect.tagViewF),OneLevelTag,
            NSStringFromCGRect(headRect.timeLabelF),OneLevelTag,
            NSStringFromCGRect(headRect.resendBtnF),OneLevelTag,
            headRect.headViewH];
}
NSString* HXHeadRectZero() {
    
    HXTagRect tagR;
    tagR.tagLabelF = tagR.tagTitleF = tagR.tagViewF = CGRectZero;
    
    HXHomeCellHeadRect headR;
    headR.headViewF = headR.iconF = headR.nameLabelF = headR.roleTitleF = headR.timeLabelF = headR.resendBtnF = CGRectZero;
    headR.tagViewF = tagR;headR.headViewH = 0;
    return HXStringFromHXHomeCellHeadRect(headR);
}

//---------------------------- 分割线 ----------------------------

HXHomeCellTextRect HXHomeCellTextRectFromString(NSString *boxString) {
    NSString *subBox = [boxString substringWithRange:NSMakeRange(1, boxString.length-2)];
    NSArray *subBoxArr = [subBox componentsSeparatedByString:OneLevelTag];
    
    HXHomeCellTextRect box;
    box.textViewF = CGRectFromString([subBoxArr firstObject]);
    box.textContentF = CGRectFromString(subBoxArr[1]);
    box.controlBtnF = CGRectFromString(subBoxArr[2]);
    box.textViewH = [[subBoxArr lastObject] floatValue];
    
    return box;
}
NSString* HXStringFromHXHomeCellTextRect(HXHomeCellTextRect textRect) {
    return [NSString stringWithFormat:@"(%@%@%@%@%@%@%f)",
            NSStringFromCGRect(textRect.textViewF),OneLevelTag,
            NSStringFromCGRect(textRect.textContentF),OneLevelTag,
            NSStringFromCGRect(textRect.controlBtnF),OneLevelTag,
            textRect.textViewH];
}
NSString* HXTextRectZero() {
    
    HXHomeCellTextRect textR;
    textR.controlBtnF = textR.textContentF = textR.textViewF = CGRectZero;
    textR.textViewH = 0;
    return HXStringFromHXHomeCellTextRect(textR);
}

//---------------------------- 分割线 ----------------------------

HXHomeCellMediaRect HXHomeCellMediaRectFromString(NSString *boxString) {
    
    NSString *subBox = [boxString substringWithRange:NSMakeRange(1, boxString.length-2)];
    NSArray *subBoxArr = [subBox componentsSeparatedByString:OneLevelTag];
    
    HXHomeCellMediaRect box;
    box.mediaViewF = CGRectFromString([subBoxArr firstObject]);
    box.perPicW = [[subBoxArr objectAtIndex:1] floatValue];
    box.perPicH = [[subBoxArr objectAtIndex:2] floatValue];
    box.spaceL = [[subBoxArr objectAtIndex:3] floatValue];
    box.mediaViewH = [[subBoxArr lastObject] floatValue];
    
    return box;
}
NSString* HXStringFromHXHomeCellMediaRect(HXHomeCellMediaRect mediaRect) {
    return [NSString stringWithFormat:@"(%@%@%f%@%f%@%f%@%f)",
            NSStringFromCGRect(mediaRect.mediaViewF),OneLevelTag,
            mediaRect.perPicW,OneLevelTag,
            mediaRect.perPicH,OneLevelTag,
            mediaRect.spaceL,OneLevelTag,
            mediaRect.mediaViewH];
}
NSString* HXMediaRectZero() {
    
    HXHomeCellMediaRect mediaR;
    mediaR.mediaViewF = CGRectZero;
    mediaR.perPicW = mediaR.perPicH = mediaR.mediaViewH = mediaR.spaceL = 0;
    return HXStringFromHXHomeCellMediaRect(mediaR);
}

//---------------------------- 分割线 ----------------------------

HXHomeCellFootRect HXHomeCellFootRectFromString(NSString *boxString) {
    
    NSString *subBox = [boxString substringWithRange:NSMakeRange(1, boxString.length-2)];
    NSArray *subBoxArr = [subBox componentsSeparatedByString:OneLevelTag];
    
    HXHomeCellFootRect box;
    box.footViewF = CGRectFromString([subBoxArr firstObject]);
    box.sureBtnF = CGRectFromString([subBoxArr objectAtIndex:1]);
    box.delBtnF = CGRectFromString([subBoxArr objectAtIndex:2]);
    box.praiseBtnF = CGRectFromString([subBoxArr objectAtIndex:3]);
    box.lineViewF = CGRectFromString([subBoxArr objectAtIndex:4]);
    box.praiserLF = CGRectFromString([subBoxArr objectAtIndex:5]);
    box.footViewH = [[subBoxArr lastObject] floatValue];
    return box;

    
}

NSString* HXStringFromHXHomeCellFootRect(HXHomeCellFootRect footRect) {
    return [NSString stringWithFormat:@"(%@%@%@%@%@%@%@%@%@%@%@%@%f)",
            NSStringFromCGRect(footRect.footViewF),OneLevelTag,
            NSStringFromCGRect(footRect.sureBtnF),OneLevelTag,
            NSStringFromCGRect(footRect.delBtnF),OneLevelTag,
            NSStringFromCGRect(footRect.praiseBtnF),OneLevelTag,
            NSStringFromCGRect(footRect.lineViewF),OneLevelTag,
            NSStringFromCGRect(footRect.praiserLF),OneLevelTag,
            footRect.footViewH];
}


NSString* HXFootRectZero() {
    
    HXHomeCellFootRect footR;
    footR.footViewF = footR.sureBtnF = footR.delBtnF = footR.praiseBtnF = footR.lineViewF = footR.praiserLF =CGRectZero;
    footR.footViewH = 0;
    return HXStringFromHXHomeCellFootRect(footR);
    
}



@implementation HXHomeTool

@end
