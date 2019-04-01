#import "ShareService.h"

typedef enum {
    ShareQQFriends = 0,   // QQ好友
    ShareQQZone, // QQ空间
} ShareQQType;

@interface ShareQQ : ShareService

@singleton( ShareQQ )

@end
