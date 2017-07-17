//
//  AppDelegate+dynamicSet.m
//  HXInvestigate
//
//  Created by 董富强 on 16/7/18.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "AppDelegate+dynamicSet.h"

@implementation AppDelegate (dynamicSet)

- (void)setupLogging {
    
    NSDictionary *config = @{
                             @"MainViewController": @{
                                     GLLoggingPageImpression: @"page imp - main page",
                                     GLLoggingTrackedEvents: @[
                                             @{
                                                 GLLoggingEventName: @"button one clicked",
                                                 GLLoggingEventSelectorName: @"buttonOneClicked:",
                                                 GLLoggingEventHandlerBlock: ^(id<AspectInfo> aspectInfo) {
                                                     NSLog(@"button one clicked");
                                                 },
                                                 },
                                             @{
                                                 GLLoggingEventName: @"button two clicked",
                                                 GLLoggingEventSelectorName: @"buttonTwoClicked:",
                                                 GLLoggingEventHandlerBlock: ^(id<AspectInfo> aspectInfo) {
                                                     NSLog(@"button two clicked");
                                                 },
                                                 },
                                             ],
                                     },
                             
                             @"DetailViewController": @{
                                     GLLoggingPageImpression: @"page imp - detail page",
                                     }
                             };
    
    
}


@end
