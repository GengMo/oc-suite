#import <_Foundation/_Modular.h>
#import <_Foundation/_Protocols.h>
#import "SNServiceParam.h"

typedef enum {
    ShareWechatFriends = 0,   // 微信好友
    ShareWechatCircleFriends, // 微信朋友圈
} ShareWechatType;

typedef enum {
    ShareWechatNotSupportedError = 8000
} ShareWechatErrorType;

@interface WechatSNService : _Service <_ShareProtocol, _SNSLoginProtocol>

@singleton( WechatSNService )

@error( notSupportedError )

@end
