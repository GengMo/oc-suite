#import <_Foundation/_Modular.h>
#import <_Foundation/_Protocols.h>
#import "SNServiceParam.h"
#import "SNServiceConfig.h"

typedef enum {
    ShareWechatFriends = 0,   // 微信好友
    ShareWechatCircleFriends, // 微信朋友圈
} ShareWechatType;

typedef enum {
    ShareWechatNotSupportedError = 8000
} ShareWechatErrorType;

@interface WechatSNService : _Service <_ShareProtocol, _SNSLoginProtocol, _SNSProtocol>

@prop_strong( SNServiceConfig *, config )

@prop_strong( NSString *, key )
@prop_strong( NSString *, secret )
@prop_strong( NSString *, scheme )
@prop_strong( NSString *, redirect )

@error( successError )
@error( failureError )
@error( cancelError )

@end
