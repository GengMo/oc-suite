//
//  ComponentSNShare.m
//  component
//
//  Created by fallen.ink on 4/26/16.
//  Copyright © 2016 OpenTeam. All rights reserved.
//

/**
 *  QQ 分享 集成注意：
 
 
 1. 在XCode中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“URL type”添加一条新的“URL scheme”，新的scheme = tencent + appid+‘.’+ content，identifier“tencentApiIdentifier”为。如果您使用的是XCode3或者更低的版本，则需要在plist文件中添加。Demo中我们注册的appid是222222
 => tencentApiIdentifier, tencent222222.content
 */

/**
 *  白名单设置
 
 如：http://www.cocoachina.com/bbs/read.php?tid-328417.html
 
 info plist
 
 <key>LSApplicationQueriesSchemes</key>
 <array>
 
 <!-- 微信 URL Scheme 白名单-->
 <string>wechat</string>
 <string>weixin</string>
 
 <!-- 新浪微博 URL Scheme 白名单-->
 <string>sinaweibohd</string>
 <string>sinaweibo</string>
 <string>sinaweibosso</string>
 <string>weibosdk</string>
 <string>weibosdk2.5</string>
 
 <!-- QQ、Qzone URL Scheme 白名单-->
 <string>mqqapi</string>
 <string>mqq</string>
 <string>mqqOpensdkSSoLogin</string>
 <string>mqqconnect</string>
 <string>mqqopensdkdataline</string>
 <string>mqqopensdkgrouptribeshare</string>
 <string>mqqopensdkfriend</string>
 <string>mqqopensdkapi</string>
 <string>mqqopensdkapiV2</string>
 <string>mqqopensdkapiV3</string>
 <string>mqzoneopensdk</string>
 <string>wtloginmqq</string>
 <string>wtloginmqq2</string>
 <string>mqqwpa</string>
 <string>mqzone</string>
 <string>mqzonev2</string>
 <string>mqzoneshare</string>
 <string>wtloginqzone</string>
 <string>mqzonewx</string>
 <string>mqzoneopensdkapiV2</string>
 <string>mqzoneopensdkapi19</string>
 <string>mqzoneopensdkapi</string>
 <string>mqzoneopensdk</string>
 
 <!-- 支付宝  URL Scheme 白名单-->
 <string>alipay</string>
 <string>alipayshare</string>
 
 </array>
 
 */

#import "SNService.h"
#import "SNServiceConfig.h"
#import "WechatSNService.h"
// https://www.jianshu.com/p/bb78f66d315c
#import <UMengUShare/WXApi.h>
#import <UMSocialCore/UMSocialManager.h>

#pragma mark -

@implementation SNService

@def_singleton( SNService )

@def_prop_strong( id<_SNServiceConfigProtocol>, wechatConfig )

@def_prop_strong( id<_ShareProtocol>, wechat )

#pragma mark -

- (instancetype)init {
    if (self = [super init]) {
        self.wechatConfig = [SNServiceConfig new];
        self.wechatConfig.supported = [WXApi isWXAppInstalled];
        
        self.wechat = [WechatSNService new];
    }
    
    return self;
}

- (void)config {
    if (self.wechatConfig.supported) {
        ASSERT(self.wechatConfig.key)
        ASSERT(self.wechatConfig.secret)
        ASSERT(self.wechatConfig.redirect)
        
        [[UMSocialManager defaultManager]
         setPlaform:UMSocialPlatformType_WechatSession
         appKey:self.wechatConfig.key
         appSecret:self.wechatConfig.secret
         redirectURL:self.wechatConfig.redirect];
    }
    
}

- (BOOL)handleOpenURL:(NSURL *)url {
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
//    [self.email parse:url application:application];
//    [self.qq parse:url application:application];
//    [self.link parse:url application:application];
//    [self.sina parse:url application:application];
//    [self.sms parse:url application:application];
//    [self.wechat parse:url application:application];
}

@end

@def_namespace( service, sns, SNService )
