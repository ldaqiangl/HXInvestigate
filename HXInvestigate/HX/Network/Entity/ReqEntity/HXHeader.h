//
//  HXHeader.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/14.
//
//

#import "Mantle.h"


@interface HXHeader : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) HXAPP *App;
@property (nonatomic,strong) HXDevice *Device;

@end
