#import <_Foundation/_Modular.h>
#import <_Foundation/_Protocols.h>

typedef enum {
    ShareWechatFriends = 0,   // 微信好友
    ShareWechatCircleFriends, // 微信朋友圈
} ShareWechatType;

typedef enum {
    ShareWechatNotSupportedError = 8000
} ShareWechatErrorType;

@interface WechatShareService : _Service <_ShareProtocol>

@singleton( WechatShareService )

@error( notSupportedError )

@end
