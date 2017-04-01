
#import "Statistics.h"
#import "StatisticsBase+UIViewController.h"

@interface Statistics ()
@property (nonatomic,weak) id delegate;
@property (nonatomic,assign) BOOL openlog;
@end

@implementation Statistics
+ (instancetype)sharedStatistic {

    @synchronized(self)
    {
        static Statistics * sharedStatistics = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedStatistics = [[super allocWithZone:NULL] init];
        });
        return sharedStatistics;
    }
}

- (void)setupStatistics:(id)delegate {
    _delegate = delegate;
    [self setupWithSingleConfiguration:@[
                                         ]];
    [self setupWithAllInstanceConfiguration:@[
                                              [StatisticsBase statisticsVCBase],
                                              
                                              ]];
}

- (void)setupWithSingleConfiguration:(NSArray *)arrayConfigs {
    
    for(NSDictionary * configs in arrayConfigs) {
        for (NSString *className in configs) {
            Class class = NSClassFromString(className);
            for (NSDictionary *event in configs[className]) {
                SEL selector = NSSelectorFromString(event[kEventSelector]);
                id block = event[kEventHandlerBlock];
                [MOAspects hookInstanceMethodForClass:class
                                             selector:selector
                                      aspectsPosition:MOAspectsPositionBefore
                                            hookRange:MOAspectsHookRangeSingle
                                           usingBlock:block];
            }
        }
    }
}

- (void)setupWithAllInstanceConfiguration:(NSArray *)arrayConfigs {
    
    for(NSDictionary * configs in arrayConfigs) {
        for (NSString *className in configs) {
            Class class = NSClassFromString(className);
            for (NSDictionary *event in configs[className]) {
                SEL selector = NSSelectorFromString(event[kEventSelector]);
                id block = event[kEventHandlerBlock];
                [MOAspects hookInstanceMethodForClass:class
                                             selector:selector
                                      aspectsPosition:MOAspectsPositionBefore
                                            hookRange:MOAspectsHookRangeAll
                                           usingBlock:block];
            }
        }
    }
}

// 上传埋点数据
- (void)startUploadStatic:(NSDictionary *)dicParam {
    _openlog = YES;
#if DEBUG
    if(_openlog){
        NSString * message = [NSString stringWithFormat:
                              @"triggerType:%@,triggerName:%@,actionId:%@,srcLocation:%@,\n"
                              "toLocation:%@,locationId:%@,refType:%@,refId:%@",
                              dicParam[tType],dicParam[tName],dicParam[Aid],
                              dicParam[src],dicParam[to],dicParam[kLocationId],
                              dicParam[type],dicParam[kRefId]
                              ];
        
        NSLog(@"message ------> %@", message);
    }
#endif

  //上传~~~~~~~
    
    
    
}

@end
