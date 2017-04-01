//
//  HXUser.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/14.
//
//

#import "Mantle.h"

@interface HXUser : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSInteger sex; //0女 1男 2未知
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *avartor;


@end
