//
//  LayoutView01.h
//  HXInvestigate
//
//  Created by 董富强 on 08/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AmbiguityTest.h"

@interface LayoutView01 : UIView

@property (nonatomic, weak) UIImageView *imgView;

- (void)updateImgView:(NSString *)name;
@end
