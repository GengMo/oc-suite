#import <UMengUShare/WXApi.h>
#import "WechatSNService.h"

// // https://www.jianshu.com/p/59e2acda0e7a

@interface WechatSNService () <WXApiDelegate>

@prop_strong( ObjectBlock, successHandler )
@prop_strong( ErrorBlock, failureHandler )
@prop_strong( NSString *, authState )


@end

@implementation WechatSNService

@def_prop_instance( SNServiceConfig, config )

@synthesize shareParam;

@def_prop_strong( ObjectBlock, successHandler )
@def_prop_strong( ErrorBlock, failureHandler )
@def_prop_strong( NSString *, authState )

@def_error( successError, _SNSLoginSuccessError, @"微信登录成功")
@def_error( failureError, _SNSLoginFailureError, @"微信登录失败")
@def_error( cancelError, _SNSLoginCancelError, @"微信登录取消")

- (instancetype)init {
    if (self = [super init]) {
        self.shareParam = [SNServiceParam new];
    }
    
    return self;
}


- (BOOL)configure {
    ASSERT(self.config.key)
    
    return [WXApi registerApp:self.config.key];
}


// MARK: -

- (void)shareWith:(id<_ShareParamProtocol>)param success:(ObjectBlock)successHandler failure:(ErrorBlock)failureHandler {
    
}

- (void)loginWithContext:(UIViewController *)context success:(ObjectBlock)successHandler failure:(ErrorBlock)failureHandler {
    ASSERT(successHandler)
    ASSERT(failureHandler)
    
    self.successHandler = successHandler;
    self.failureHandler = failureHandler;
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    self.authState = req.state = [NSString randomLength:32];
    [WXApi sendAuthReq:req viewController:context delegate:self];
    
}

- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendAuthResp class]]) {
        
        SendAuthResp *authResp = (SendAuthResp *)resp;
        
        /* Prevent Cross Site Request Forgery */
        if (![authResp.state isEqualToString:self.authState]) {
            invoke_nullable_block(self.failureHandler, self.failureError)
        } else {
            switch (resp.errCode) {
                case WXSuccess:
                {
                    NSLog(@"RESP:code:%@,state:%@\n", authResp.code, authResp.state);
                    NSMutableDictionary *respDict = [@{} mutableCopy];
                    
                    respDict[@"code"] = authResp.code;
                    
                    invoke_nullable_block(self.successHandler, respDict)
                }
                    break;
                case WXErrCodeAuthDeny:
                {
                    invoke_nullable_block(self.failureHandler, self.failureError)
                }
                    break;
                case WXErrCodeUserCancel:
                {
                    invoke_nullable_block(self.failureHandler, self.cancelError)
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    self.successHandler = nil;
    self.failureHandler = nil;
}


- (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options {
    return [self handleOpenURL:url];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}

@end
