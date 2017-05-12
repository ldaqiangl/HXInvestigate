//
//  UIView+AmbiguityTest.h
//  HXInvestigate
//
//  Created by 董富强 on 08/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AmbiguityTest)

//测试布局（视图及其内部子视图）有没有歧义
- (void)testAmbiguidty;

- (NSArray *)dqAllConstraints;

UIEdgeInsets BuildInsets(CGRect alignmentRect, CGRect imageBounds);

@end
