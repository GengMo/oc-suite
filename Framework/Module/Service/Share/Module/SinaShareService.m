#import <_Foundation/_Foundation.h>
#import "ShareSina.h"
#import "WeiboSDK.h"
#import "ShareHelper.h"

@interface ShareSina () <WeiboSDKDelegate>

@end

@implementation ShareSina

@def_singleton( ShareSina )

- (void)configure {
    [WeiboSDK registerApp:self.config.appId];
    [WeiboSDK enableDebugMode:YES];
}

- (BOOL)supported {
    return [WeiboSDK isCanShareInWeiboAPP] && [WeiboSDK isWeiboAppInstalled] && self.config.supported;
}

- (BOOL)share:(ShareParamBuilder *)paramBuilder onViewController:(UIViewController *)viewController {
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShareWithParamBuilder:paramBuilder] authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"ShareActivityVC"};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
    
    return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    if ([url.scheme isEqualToString:self.config.appId]) {
        [WeiboSDK handleOpenURL:url delegate:self];
    }
}

- (WBMessageObject *)messageToShareWithParamBuilder:(ShareParamBuilder *)paramBuilder {
    if ([self supported]) {
        WBMessageObject *message = [WBMessageObject message];
        message.text = [NSString stringWithFormat:@"%@%@ @易孜", paramBuilder.title, paramBuilder.detail];
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = paramBuilder.objectId;
        webpage.title = paramBuilder.title;
        webpage.description = paramBuilder.detail;
        webpage.thumbnailData = [ShareHelper compressThumbImage:paramBuilder.image];
        webpage.webpageUrl = paramBuilder.url;
        message.mediaObject = webpage;
        return message;
    } else {
        WBMessageObject *message = [WBMessageObject message];
        message.text = [NSString stringWithFormat:@"%@%@ @易孜", paramBuilder.title, paramBuilder.detail];
        return message;
    }
}


#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeUserCancel:{
                INFO(@"微博分享.用户取消发送");
            }
                break;
            case WeiboSDKResponseStatusCodeSentFail:{
                INFO(@"微博分享.发送失败");
            }
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:{
                INFO(@"微博分享.授权失败");
            }
                break;
            case WeiboSDKResponseStatusCodeShareInSDKFailed:{
                INFO(@"微博分享.分享失败");
            }
                break;
            case WeiboSDKResponseStatusCodeUnsupport:{
                INFO(@"微博分享.不支持请求");
            }
                break;
                
            default:
                break;
        }
    }
}


@end
