//#import "_ShareConfigProtocol.h"
#import "_Foundation.h"
#import "_ShareParamProtocol.h"

@protocol _ShareProtocol <NSObject>

//@property (nonatomic, assign) _SharePlatformType platform;

@property (nonatomic, strong) id<_ShareParamProtocol> shareParam;

//- (void)handleShareReponse:(NSURL *)url application:(UIApplication *)application;

// Share to single session
- (void)shareWith:(id<_ShareParamProtocol>)param
          success:(ObjectBlock)successHandler
          failure:(ErrorBlock)failureHandler;

@end
