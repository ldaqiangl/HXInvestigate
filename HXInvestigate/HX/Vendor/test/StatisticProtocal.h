
#import <Foundation/Foundation.h>

@protocol StatisticUploadProtocal <NSObject>
@optional
- (void)uploadStatistics:(NSDictionary *)dicParam;
@end


