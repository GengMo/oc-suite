#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    _SharePlatformWechatMask = 0x000f,         // 0000 0000 0000 1111
    _SharePlatformWechatSession = 1 << 0,      // 0000 0000 0000 0001
    _SharePlatformWechatTimeLine = 1 << 1,     // 0000 0000 0000 0010
    _SharePlatformWechatFavorate = 1 << 2,     // 0000 0000 0000 0100
    
    _SharePlatformWeiboMask = 0x00f0,          // 0000 0000 1111 0000
    _SharePlatformWeiboCommon = 1 << 4,        // 0000 0000 0001 0000
    
    _SharePlatformTencentMask = 0x0f00,        // 0000 1111 0000 0000
    _SharePlatformTencentQQ = 1 << 8,          // 0000 0001 0000 0000
    _SharePlatformTencentQZone = 1 << 9,       // 0000 0010 0000 0000
} _SharePlatformType;

//typedef enum

typedef enum : NSUInteger {
    _SNSLoginSuccessError = 1000,
    _SNSLoginFailureError = 1001,
    _SNSLoginCancelError = 1002,
} _SNSErrorType;
