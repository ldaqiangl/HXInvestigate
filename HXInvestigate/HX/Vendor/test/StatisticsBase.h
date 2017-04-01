
// chu fa fang shi
typedef enum StatisticTriggerType {
    
    // ennter vc
    eEnterVc = 1,
    // close vc
    eCloseVc = 2,
   
}StatisticTriggerType;




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StatisticsConst.h"
#import "StatisticProtocal.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Statistics.h"
#import "MBProgressHUD.h"


@interface UIView (statistic)

- (NSString *)subViewsTextForStatistics;

@end

@interface StatisticsBase : NSObject


+ (NSDictionary *)statisticsBase;

+ (MBProgressHUD *)hudview;

@end
