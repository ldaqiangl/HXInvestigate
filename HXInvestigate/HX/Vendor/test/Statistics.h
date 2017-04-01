#import <Foundation/Foundation.h>
#import "StatisticsConst.h"
#import "StatisticsBase.h"
#import "MOAspects.h"

@interface Statistics : NSObject

+ (instancetype)sharedStatistic;

- (void)setupStatistics:(id)delegate;

- (void)startUploadStatic:(NSDictionary *)dicParam;

@end
