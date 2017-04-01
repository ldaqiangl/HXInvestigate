//
//  HXBusinessLogic.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

/*************************
 *   业务逻辑--接口列表    *
 *************************/

#import "HXNetworkMacors.h"

#ifndef HXBusinessLogic_h
#define HXBusinessLogic_h


/**   制定后台接口协议格式 （请求） **
 
 POST / HTTP/1.1
 Host: api.hxkid.com
 User-Agent: Hxkid-MediaSys/Client 1.0.0.0
 Content-Length:Content-Length-Value
 
 {
     “Header”:
             {
                “App”:
             {
                 “PackageName”:Package-Name-Value,
                 “AppName”:App-Name-Value,
                 “Version”:App-Version-Value,
                 “MobileType”:Mobile-Type-Value,
                 “Channel”:Channel-Value
             },
     “Device”:
             {
                 “Platform”:Platform-Value,
                 “Model”:Model-Value,
                 “Factory”:Factory-Value,
                 “ScreenSize”:Screen-Size-Value,
                 “Denstiy”:Denstiy-Value,
                 “IMEI”:IMEI-Value,
                 “Mac”:Mac-Value,
                 “ClientId”:Channel-Value
             },
     “User”:
             {
                “Token”:User-Token-Value
             }
     },
     Body:
             {
                Request-Body-Json-Value
             }
 }
 
 
 */


/** 制定后台接口协议格式 （应答）
 
 HTTP/1.1 200 OK
 Content-Type: text/html; charset=utf-8
 Content-Length: Content-Length-Value
 Date: Date-Value
 
 {
     “code”:Result-Code-Value,
     “message”:Message-Value,
     “body”:
     {
        Response-Body-Json-Value
     }
 }
 
 */


#define kEventHTTPAddress [NSString stringWithFormat:@"%@/api",kHXHTTPHost]

/**--------------------
 登录、注册
 --------------------*/
/** 1.登录USRE_LOGIN */
#define kUserLogin [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"userLogin"]
/** 2.注册 */
#define kUserRegister [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"userRegist"]
/** 3.发送短信接口 */
#define kUserSendMessage [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"sendMessageServer"]
/** 4.发送邮箱 获取验证码GET_MAIL_CODE */
#define kUserSendMail [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"sendEmailServer"]
/** 5.短信找回密码PERSONAL_FORGOTPWD_GET_CODE  ?phone= */
#define kUserForgotMessagePass [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"sendMessageServerBack"]
/** 6.邮箱找回密码ORG_FORGOTPWD_GET_CODE  ?email= */
#define kUserForgotMailPass [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"sendEmailServerBack"]
/** 7.找回密码提交 USER_FORGOTPWD_SUBMIT  */
#define kUserForgotSubmit [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"findUserPassFlush"]
/** 8.第三方登录 */
#define KUserThirdLoginPort [NSString stringWithFormat:@"%@/%@",kUserHTTPAddress,@"thirdUserLogin"]


/**--------------------
 发现
 --------------------*/


#endif /* HXBusinessLogic_h */
