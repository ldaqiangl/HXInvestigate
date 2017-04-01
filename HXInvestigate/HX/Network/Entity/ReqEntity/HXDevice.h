//
//  HXDevice.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/14.
//
//

#import "Mantle.h"

@interface HXDevice : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy)NSString *Platform;
@property (nonatomic,copy)NSString *Model;
@property (nonatomic,copy)NSString *Factory;
@property (nonatomic,copy)NSString *ScreenSize;
@property (nonatomic,copy)NSString *Denstiy;
@property (nonatomic,copy)NSString *IMEI;
@property (nonatomic,copy)NSString *Mac;
@property (nonatomic,copy)NSString *ClientId;


@end
