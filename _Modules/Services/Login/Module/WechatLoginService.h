#import <_Foundation/_All.h>

@interface WechatLoginService : _Service <_SNSLoginProtocol>

@singleton( WechatLoginService )

@prop_strong( NSString *, key )
@prop_strong( NSString *, secret )
@prop_strong( NSString *, scheme )
@prop_strong( NSString *, redirect )

@error( successError )
@error( failureError )
@error( cancelError )

- (void)config;

@end
