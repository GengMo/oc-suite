#import <UMengUShare/WXApi.h>

#import "WechatLoginService.h"

// https://www.jianshu.com/p/59e2acda0e7a

@interface WechatLoginService () <WXApiDelegate>

@prop_strong( ObjectBlock, successHandler )
@prop_strong( ErrorBlock, failureHandler )
@prop_strong( NSString *, authState )

@end

@implementation WechatLoginService

@def_singleton( WechatLoginService )


- (void)config {
    ASSERT(self.key)
    
    [WXApi registerApp:self.key];
}


@end
