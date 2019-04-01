//#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialCore/UMSocialManager.h>
#import "LoginService.h"

@implementation LoginService

@def_singleton( LoginService )

@def_prop_singleton( WechatLoginService, wechat )

@end

@def_namespace( service, login, LoginService )
