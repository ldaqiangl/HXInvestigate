//
//  HXSelectedItemCell.h
//  HXInvestigate
//
//  Created by 董富强 on 2016/11/10.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXClassInfoItem.h"

@interface HXSelectedItemCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *itemLabel;

- (void)setCellInfoWithClassItem:(HXClassInfoItem *)classItem;
@end
