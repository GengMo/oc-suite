#import "_Protocol.h"
#import "_SNSConfigProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol _SNSProtocol <NSObject>

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @note 此函数在6.3版本加入
 */
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @note 此函数在6.3版本加入
 */
- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url 第三方sdk的打开本app的回调的url
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 */
- (BOOL)handleOpenURL:(NSURL *)url;

//@property (nonatomic, strong) id<_ShareProtocol> wechat;
//@property (nonatomic, strong) id<_ShareProtocol> weibo;
//@property (nonatomic, strong) id<_ShareProtocol> tencent;
//
//@property (nonatomic, strong) id<_ShareParamProtocol> param;
//
//@property (nonatomic, strong) void (^ afterProcessHandler)(id<_ShareParamProtocol> param);

//- (void)shareSuccess:(void(^)(void))successHandler
//             failure:(void(^)(NSError *error))failureHandler;

//- (BOOL)availableForPlatform:(_SharePlatformType)platformType;
//
//- (NSUInteger)typeOfPlatform:(_SharePlatformType)platformType;
//- (NSUInteger)sceneTypeOfPlatform:(_SharePlatformType)platformType;

@end

NS_ASSUME_NONNULL_END
