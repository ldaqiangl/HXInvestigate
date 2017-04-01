//
//  HXClassInfoItem.h
//  HXInvestigate
//
//  Created by 董富强 on 2016/11/10.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXClassInfoItem : NSObject

/** 班级ID */
@property (nonatomic, copy) NSString *classID;
/** 班级名称 */
@property (nonatomic, copy) NSString *className;
/** 当前班级是否选中(YES：选中,NO：不选中) */
@property (nonatomic, assign) BOOL isSelected;

@end
