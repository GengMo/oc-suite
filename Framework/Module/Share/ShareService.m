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

#import "ShareService.h"
#import "LinkShareService.h"
#import "TencentShareService.h"
#import "EmailShareService.h"
#import "SmsShareService.h"
#import "SinaShareService.h"
#import "WechatShareService.h"

#pragma mark -

@implementation ShareService

@def_singleton( ShareService )

@def_prop_instance( ShareServiceConfig, wechatConfig )
@def_prop_instance( ShareServiceConfig, qqConfig )
@def_prop_instance( ShareServiceConfig, sinaConfig )
@def_prop_instance( ShareServiceConfig, smsConfig )
@def_prop_instance( ShareServiceConfig, emailConfig )
@def_prop_instance( ShareServiceConfig, linkConfig )

@def_prop_singleton( ShareLink, link )
@def_prop_singleton( ShareQQ, qq )
@def_prop_singleton( ShareEmail, email )
@def_prop_singleton( ShareSina, sina )
@def_prop_singleton( ShareSms, sms )
@def_prop_singleton( WechatShareService, wechat )

#pragma mark -

- (void)wechatConfig:(ShareServiceConfigBlock)wechatConfigHandler
            qqConfig:(ShareServiceConfigBlock)qqConfigHandler
          sinaConfig:(ShareServiceConfigBlock)sinaConfigHandler
           smsConfig:(ShareServiceConfigBlock)smsConfigHandler
         emailConfig:(ShareServiceConfigBlock)emailConfigHandler
          linkConfig:(ShareServiceConfigBlock)linkConfigHandler {
    
    if (wechatConfigHandler) {
        self.wechatConfig.supported = wechatConfigHandler(self.wechatConfig);
    }
    
    if (qqConfigHandler) {
        self.qqConfig.supported = qqConfigHandler(self.qqConfig);
    }
    
    if (sinaConfigHandler) {
        self.sinaConfig.supported = sinaConfigHandler(self.sinaConfig);
    }
    
    if (smsConfigHandler) {
        self.smsConfig.supported = smsConfigHandler(self.smsConfig);
    }
    
    if (emailConfigHandler) {
        self.emailConfig.supported = emailConfigHandler(self.emailConfig);
    }
    
    if (linkConfigHandler) {
        self.linkConfig.supported = linkConfigHandler(self.linkConfig);
    }
    
    [self configure];
}

#pragma mark -

- (void)configure {
    if (self.linkConfig.supported) {
        self.link.config = self.linkConfig;
        [self.link configure];
    }
    
    if (self.qqConfig.supported) {
        self.qq.config = self.qqConfig;
        [self.qq configure];
    }
    
    if (self.emailConfig.supported) {
        self.email.config = self.emailConfig;
        [self.email configure];
    }
    
    if (self.sinaConfig.supported) {
        self.sina.config = self.sinaConfig;
        [self.sina configure];
    }
    
    if (self.smsConfig.supported) {
        self.sms.config = self.smsConfig;
        [self.sms configure];
    }
    
    if (self.wechatConfig.supported) {
//        self.wechat.config = self.wechatConfig;
        [self.wechat configure];
    }
}

- (BOOL)supported {
    return self.config.supported;
}

- (BOOL)share:(ShareParamBuilder *)paramBuilder onViewController:(UIViewController *)viewController {
    exceptioning(@"未实现")
    
    return NO;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    [self.email parse:url application:application];
    [self.qq parse:url application:application];
    [self.link parse:url application:application];
    [self.sina parse:url application:application];
    [self.sms parse:url application:application];
//    [self.wechat parse:url application:application];
}

@end
