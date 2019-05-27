
#import <Framework/_Foundation.h>

// ----------------------------------
// Macro
// ----------------------------------

#undef  app_config
#define app_config          [_AppConfig sharedInstance]

#define app_platform_name   [AppConfig sharedInstance].platformName
#define app_name            [AppConfig sharedInstance].appName
#define app_identifier      [AppConfig sharedInstance].appIdentifier
#define app_description     [AppConfig sharedInstance].appDescription
#define app_version_serial  [AppConfig sharedInstance].appVersionSerial

#define app_udid            [[_SystemInfo sharedInstance] deviceUDID]

// ----------------------------------
// Pre Declaration
// ----------------------------------

@protocol APNServiceDelegate;

// ----------------------------------
// Class Definition
// ----------------------------------

@interface _AppConfig : NSObject

@singleton( _AppConfig )

// 广告配置
@prop_assign(BOOL, enabledLaunchAdvertise) // 启动广告，默认：NO
@prop_assign(CGFloat, launchAdvertiseDuration)

// 地图-高德SDK配置，没有配置，默认关闭
@prop_strong(NSString *, mapApiKey)

// 分享-微信配置
@prop_strong(NSString *, wechatAppId)
@prop_strong(NSString *, wechatScheme)

// 推送配置
@prop_strong(NSString *, pushKey)
@prop_strong(NSString *, pushChannel) // 需要监听的频道
@prop_strong(id<APNServiceDelegate>, pushDelegate)

// 应用配置信息
@prop_readonly(NSString *, appDescriptionAsString)
@prop_readonly(NSString *, appDescriptionAsDictionary)

@end
