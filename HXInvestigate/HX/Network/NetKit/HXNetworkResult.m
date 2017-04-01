//
//  HXNetworkResult.m
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

#import "HXNetworkResult.h"

@implementation HXNetworkResult

- (BOOL)isSuccess {
    return [[NSString stringWithFormat:@"%@",self.code] isEqualToString:@"0"];
}

@end
