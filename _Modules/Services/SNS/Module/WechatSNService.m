
#import "WechatSNService.h"
#import <UMSocialCore/UMSocialManager.h>
#import <UMSocialCore/UMSocialResponse.h>

@interface WechatSNService ()

@end

@implementation WechatSNService

//@synthesize platform;
@synthesize shareParam;

// MARK: -

- (instancetype)init {
    if (self = [super init]) {
        self.shareParam = [SNServiceParam new];
    }
    
    return self;
}


// MARK: -

- (void)shareWith:(id<_ShareParamProtocol>)param success:(ObjectBlock)successHandler failure:(ErrorBlock)failureHandler {
    
}

// https://www.jianshu.com/p/e69ccae01fc1
// UMSocialPlatformType_Sina
- (void)loginWithContext:(UIViewController *)context
                 success:(ObjectBlock)successHandler
                 failure:(ErrorBlock)failureHandler {
    [[UMSocialManager defaultManager]
     getUserInfoWithPlatform:UMSocialPlatformType_WechatSession
     currentViewController:context
     completion:^(id result, NSError *error) {
         
         if (error) {
             invoke_nullable_block(failureHandler, error)
         } else {
             invoke_nullable_block(successHandler, result)
         }
//        UMSocialUserInfoResponse *resp = result;
//
//        // 第三方登录数据(为空表示平台未提供)
//        // 授权数据
//        NSLog(@" uid: %@", resp.uid);
//        NSLog(@" openid: %@", resp.openid);
//        NSLog(@" accessToken: %@", resp.accessToken);
//        NSLog(@" refreshToken: %@", resp.refreshToken);
//        NSLog(@" expiration: %@", resp.expiration);
//
//        // 用户数据
//        NSLog(@" name: %@", resp.name);
//        NSLog(@" iconurl: %@", resp.iconurl);
//        NSLog(@" gender: %@", resp.unionGender);
//
//        // 第三方平台SDK原始数据
//        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

@end
