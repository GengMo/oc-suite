#import "ShareService.h"

typedef enum {
    ShareWechatFriends = 0,   // 微信好友
    ShareWechatCircleFriends, // 微信朋友圈
} ShareWechatType;

@interface ShareWechat : ShareService

@singleton( ShareWechat )

@end
