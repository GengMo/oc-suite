#import <_Foundation/_Modular.h>
#import "WechatLoginService.h"

@interface LoginService : _Service

@singleton( LoginService )

@prop_singleton( WechatLoginService, wechat )

@end

@namespace( service, login, LoginService )
