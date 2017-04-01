#import "StatisticsBase+UIViewController.h"

@implementation StatisticsBase (UIViewController)
+ (NSDictionary *)statisticsVCBase {
    return @{
             kUIViewController:@[
                     
                     @{
                         kEventSelector: @"viewWillAppear:",
                         kEventHandlerBlock: ^(UIViewController *controller,
                                              BOOL animated ) {
                             
                             NSString * className = NSStringFromClass([controller class]);
                             if(([controller isKindOfClass:NSClassFromString(@"BaseViewController")] &&
                                 [className isEqualToString:@"BaseViewController"] == NO) ) {

                                 NSString * triggerName = @"method=viewWillAppear:";
                                 
                                 NSMutableDictionary * dicStatistic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                       [NSString stringWithFormat:@"%zd",eEnterVc],tType,
                                                                       triggerName,tName,
                                                                       @"",Aid,
                                                                       @"",src,
                                                                       className,to,
                                                                       @"",kLocationId,
                                                                       @"",type,
                                                                       @"",kRefId,nil];
                                 [[Statistics sharedStatistic] startUploadStatic:dicStatistic];
                                 
                             }
                         }
                         },
                     
                     @{
                         kEventSelector: @"viewWillDisappear:",
                         kEventHandlerBlock: ^(UIViewController *controller,
                                              BOOL animated ) {
                             
                             NSString * className = NSStringFromClass([controller class]);
                             if(([controller isKindOfClass:NSClassFromString(@"BaseViewController")] &&
                                 [className isEqualToString:@"BaseViewController"] == NO) ) {
                                 
                                 NSString * triggerName = @"method=viewWillDisappear:";

                                 NSMutableDictionary * dicStatistic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                       [NSString stringWithFormat:@"%zd",eCloseVc],type,
                                                                       triggerName,tName,
                                                                       @"",Aid,
                                                                       className,src,
                                                                       @"",to,
                                                                       @"",kLocationId,
                                                                       @"",type,
                                                                       @"",kRefId,nil];
                                 [[Statistics sharedStatistic] startUploadStatic:dicStatistic];

                             }
                         }
                         }
                     ]

             };
}

@end
