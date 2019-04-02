#import "_Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol _SNServiceConfigProtocol <_Protocol>

@property (nonatomic, assign) NSUInteger platform;

@property (nonatomic, strong) NSString *key; // app key / app id
@property (nonatomic, strong) NSString *secret; // app secret
@property (nonatomic, strong) NSString *scheme; // url scheme
@property (nonatomic, strong) NSString *redirect; // redirect url

/**
 *  @brief scope
 *
 *  @wechat snsapi_base, snsapi_userinfo
 */
@property (nonatomic, strong) NSString *scope;

@property (nonatomic, assign) BOOL supported; //  使用方主动控制，是否支持。

@end

NS_ASSUME_NONNULL_END
