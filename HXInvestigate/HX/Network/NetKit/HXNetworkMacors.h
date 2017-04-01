//
//  HXNetworkMacors.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/15.
//
//

#ifndef HXNetworkMacors_h
#define HXNetworkMacors_h

///是否打印log
#define kHXEnableLog 0

///0-测试地址 1-生产地址
#define kHXNetworkRelease 1


#if kHXNetworkRelease

#define kHXHTTPHost @"http://api.hxkid.com"

#else

#define kHXHTTPHost @"http://test.testhxkid.com"

#endif


#define kHXBody @"Body"
#define kHXCode @"Code"
#define kHXMessage @"Message"

#define kHXbody @"body"
#define kHXcode @"code"
#define kHXmessage @"message"


#endif /* HXNetworkMacors_h */
