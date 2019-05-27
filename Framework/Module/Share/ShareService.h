#import <Framework/_Foundation.h>
#import "ShareServiceConfig.h"
#import "ShareParamBuilder.h"

@class ShareLink;
@class ShareQQ;
@class ShareEmail;
@class ShareSina;
@class ShareSms;
@class WechatShareService;

typedef BOOL (^ ShareServiceConfigBlock)(ShareServiceConfig *config);

@interface ShareService : NSObject

@singleton( ShareService )

@prop_instance( ShareServiceConfig, wechatConfig )
@prop_instance( ShareServiceConfig, qqConfig )
@prop_instance( ShareServiceConfig, sinaConfig )
@prop_instance( ShareServiceConfig, smsConfig )
@prop_instance( ShareServiceConfig, emailConfig )
@prop_instance( ShareServiceConfig, linkConfig )

@prop_singleton( ShareLink, link )
@prop_singleton( ShareQQ, qq )
@prop_singleton( ShareEmail, email )
@prop_singleton( ShareSina, sina )
@prop_singleton( ShareSms, sms )
@prop_singleton( WechatShareService, wechat )

#pragma mark - 统一配置接口

/**
 *  Leave config to client, and if handler return BOOL means he donot want.
 */
- (void)wechatConfig:(ShareServiceConfigBlock)wechatConfigHandler
            qqConfig:(ShareServiceConfigBlock)qqConfigHandler
          sinaConfig:(ShareServiceConfigBlock)sinaConfigHandler
           smsConfig:(ShareServiceConfigBlock)smsConfigHandler
         emailConfig:(ShareServiceConfigBlock)emailConfigHandler
          linkConfig:(ShareServiceConfigBlock)linkConfigHandler;

#pragma mark - Can be override

- (void)configure;

- (BOOL)supported;

/**
 *  分享成功
 */
@property (nonatomic, copy) ObjectBlock     succeedHandler;

/**
 *  分享失败
 */
@property (nonatomic, copy) ErrorBlock      failedHandler;

/**
 *  When inherited, this field should be set appropriate.
 */
@property (nonatomic, strong) ShareServiceConfig *config;

/**
 *  Share to.
 */
- (BOOL)share:(ShareParamBuilder *)paramBuilder onViewController:(UIViewController *)viewController;

/**
 *  Call when ApplicationDelegate touch application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
    Should not be call as [super parse:url application:application]
 *
 *  @param url         url
 *  @param application application
 */
- (void)parse:(NSURL *)url application:(UIApplication *)application;

@end



