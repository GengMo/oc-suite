#import <_Foundation/_Foundation.h>
#import <_Foundation/_Modular.h>
#import <_Foundation/_Protocols.h>

//typedef BOOL (^ SNServiceConfigBlock)(SNServiceConfig *config);

@interface SNService : _Service <_SNSProtocol>

@singleton( SNService )

@prop_strong( id<_SNServiceConfigProtocol>, wechatConfig )

@prop_strong( id<_ShareProtocol>, wechat )

#pragma mark - Can be override

- (void)config;

/**
 *  分享成功
 */
//@property (nonatomic, copy) ObjectBlock     succeedHandler;

/**
 *  分享失败
 */
//@property (nonatomic, copy) ErrorBlock      failedHandler;

/**
 *  When inherited, this field should be set appropriate.
 */
//@property (nonatomic, strong) SNServiceConfig *config;

/**
 *  Share to.
 */
//- (BOOL)share:(ShareParamBuilder *)paramBuilder onViewController:(UIViewController *)viewController;

/**
 *  Call when ApplicationDelegate touch application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
    Should not be call as [super parse:url application:application]
 *
 *  @param url         url
 *  @param application application
 */
//- (void)parse:(NSURL *)url application:(UIApplication *)application;

@end

@namespace( service, sns, SNService )

