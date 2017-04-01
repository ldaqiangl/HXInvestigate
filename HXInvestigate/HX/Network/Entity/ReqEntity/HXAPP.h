//
//  HXAPP.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/14.
//
//

#import "Mantle.h"

@interface HXAPP : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy)NSString *PackageName;
@property (nonatomic,copy)NSString *AppName;
@property (nonatomic,copy)NSString *Version;
@property (nonatomic,copy)NSString *MobileType;
@property (nonatomic,copy)NSString *Channel;


@end
