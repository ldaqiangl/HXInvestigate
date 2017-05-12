//
//  UIView+AmbiguityTest.m
//  HXInvestigate
//
//  Created by 董富强 on 08/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import "UIView+AmbiguityTest.h"
#import "AppDelegate.h"
@implementation UIView (AmbiguityTest)

- (void)testAmbiguidty {
    
    NSLog(@"<%@:0x%0x>: %@",
          self.class.description,
          (int)self,
          self.hasAmbiguousLayout ? @"Ambiguous" : @"Unambiguous");
    
    for (UIView *view in self.subviews) {
        
        [view testAmbiguidty];
    }
    
//    if (self.hasAmbiguousLayout) {
//        //纠正有歧义的布局
//        [self exerciseAmbiguityInLayout];
//    }
}

- (NSArray *)dqAllConstraints {
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:self.constraints];
    
    for (UIView *view in self.subviews) {
        
        [arr addObjectsFromArray:[view dqAllConstraints]];
    }
    
    return arr;
}

UIEdgeInsets BuildInsets(CGRect alignmentRect, CGRect imageBounds) {
    
    CGRect targetRect = CGRectIntersection(alignmentRect, imageBounds);
    
    UIEdgeInsets insets;
    
    insets.left = CGRectGetMinX(targetRect) - CGRectGetMaxX(imageBounds);
    insets.right = CGRectGetMaxX(targetRect) - CGRectGetMaxX(imageBounds);
    insets.top = CGRectGetMinY(targetRect) - CGRectGetMinY(imageBounds);
    insets.bottom = CGRectGetMaxY(targetRect) - CGRectGetMaxY(imageBounds);
    
    return insets;
}
@end
