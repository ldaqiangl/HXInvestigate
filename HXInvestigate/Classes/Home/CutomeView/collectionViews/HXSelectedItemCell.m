//
//  HXSelectedItemCell.m
//  HXInvestigate
//
//  Created by 董富强 on 2016/11/10.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HXSelectedItemCell.h"

@implementation HXSelectedItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.font = [UIFont appFontWith_BSExt:26.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blueColor];
        self.itemLabel = label;
        [self.contentView addSubview:self.itemLabel];
        
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0;
        label.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)setCellInfoWithClassItem:(HXClassInfoItem *)classItem {
    
    UIColor *backColor = [UIColor whiteColor];
    UIColor *textColor = [UIColor blackColor];
    
    if (classItem.isSelected) {
        
        backColor = [UIColor blueColor];
        textColor = [UIColor whiteColor];
    }
    
    self.contentView.backgroundColor = backColor;
    self.itemLabel.textColor = textColor;
    
    self.itemLabel.text = classItem.className;
}


@end
