
#import "_AppConfig.h"

@interface _AppConfig ()

// 后台请求统一添加appplatform, appname, appversion三个字段，方便线上问题紧急修复（带URL域名）
// 后台请求统一添加guid（唯一标示符），方便后台分析日志（带URL域名）

// 可参考：https://blog.csdn.net/weixin_40876113/article/details/80770094
// 崩溃日志收集

// platform     - 应用平台 ios/android

// devicename   - 设备名称
// devicemodel  - 设备模型
// sysname      - 系统名称
// sysver       - 系统版本
// guid         - 设备ID
// resolution   - 屏幕分辨率
// nettype      - 网络类型

// appid        - app bundle id
// appver       - 应用版本

// user信息      - 数据库中抽取

// 应用配置
@prop_strong(NSString *, platform)

@prop_strong(NSString *, devicename)
@prop_strong(NSString *, devicemodel)

@prop_strong(NSString *, sysname)
@prop_strong(NSString *, sysver)

@prop_strong(NSString *, guid)
@prop_strong(NSString *, resolution)
@prop_strong(NSString *, nettype)

@prop_strong(NSString *, appname) // app display name , as it display at front screen~
@prop_strong(NSString *, appid)
@prop_strong(NSString *, appver) // 版本格式：主版本号.次版本号.修订号，版本号规则如下（面向SDK、应用开发）：1. 主版本号（不兼容的API修改、重要模块功能新增）2. 次版本号（向下兼容的功能新增、个别模块功能扩容） 3. 修订号（向下兼容的问题修正、个别模块功能bug修复）
@prop_assign(int32_t , appverserial) // 用于版本比对的整形数字, 存放在info.plist中，key is :CFApplicationVersionSerial


@end

@implementation _AppConfig

@def_singleton( _AppConfig )

//@def_prop_singleton( _AppRater, rater )

- (instancetype)init {
    if (self = [super init]) {
        self.enabledLaunchAdvertise = NO;
        self.launchAdvertiseDuration = 3.f;
        
        _platform       = @"ios";
        _appname        = app_display_name;
        _appver         = app_version;
        
        NSString *bundleId = app_bundle_id;
        NSArray *bundleStrs = [bundleId componentsSeparatedByString:@"."];
        _appid = [bundleStrs safeStringAtIndex:2];
        
        NSString *appVersionSerialString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFApplicationVersionSerial"];
        _appverserial = [appVersionSerialString intValue];
    }
    
    return self;
}

- (NSString *)appDescriptionAsString {
    static NSString *const apppltFirstSubStr = @"?appplatform=";
    static NSString *const appnameFirstSubStr = @"?appname=";
    static NSString *const appverFirstSubStr = @"?appversion=";
    static NSString *const guidFirstSubStr = @"?guid=";
    
    static NSString *const apppltNotFirstSubStr = @"&appplatform=";
    static NSString *const appnameNotFirstSubStr = @"&appname=";
    static NSString *const appverNotFirstSubStr = @"&appversion=";
    static NSString *const guidNotFirstSubStr = @"&guid=";
    
    NSMutableString *resultString = [NSMutableString new];
    if (([resultString rangeOfString:apppltFirstSubStr].location == NSNotFound) && ([resultString rangeOfString:apppltNotFirstSubStr].location == NSNotFound)) {
        [resultString appendFormat:@"%@%@", ([resultString rangeOfString:@"?"].location == NSNotFound) ? apppltFirstSubStr : apppltNotFirstSubStr, self.platform];
    }
    if (([resultString rangeOfString:appnameFirstSubStr].location == NSNotFound) && ([resultString rangeOfString:appnameNotFirstSubStr].location == NSNotFound)) {
        [resultString appendFormat:@"%@%@", appnameNotFirstSubStr, self.appname];
    }
    if (([resultString rangeOfString:appverFirstSubStr].location == NSNotFound) && ([resultString rangeOfString:appverNotFirstSubStr].location == NSNotFound)) {
        [resultString appendFormat:@"%@%@", appverNotFirstSubStr, app_bundle_name];
    }
    if (([resultString rangeOfString:guidFirstSubStr].location == NSNotFound) && ([resultString rangeOfString:guidNotFirstSubStr].location == NSNotFound)) {
        [resultString appendFormat:@"%@%@", guidNotFirstSubStr, [[_Device sharedInstance] deviceUDID]];
    }
    
    return resultString;
}

- (NSDictionary *)appDescriptionAsDictionary {
    return nil;
}

@end
