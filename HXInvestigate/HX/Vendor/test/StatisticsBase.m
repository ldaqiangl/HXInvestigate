#import "StatisticsBase.h"

@implementation UIView (statistic)
- (NSString *)subViewsTextForStatistics
{
    NSMutableArray *arraySubText = [NSMutableArray array];
    for (UIView *subView in [self subviews])
    {
        if ([subView isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)subView;
            NSString *labelText = [label text];
            if (labelText != nil && [labelText length] > 0)
            {
                [arraySubText addObject:labelText];
            }
        }
        else if ([subView isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)subView;
            NSString *buttonTitle = [[button titleLabel] text];
            if (buttonTitle != nil && [buttonTitle length] > 0)
            {
                [arraySubText addObject:buttonTitle];
            }
        }
    }
    
    return [arraySubText componentsJoinedByString:@","];;
}

@end


@implementation StatisticsBase

+ (NSDictionary *)statisticsBase {
    return nil;
}

@end



