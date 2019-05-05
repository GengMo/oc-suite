//
//  _SNServiceConfig.h
//  _Foundation
//
//  Created by fallen.ink on 2019/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol _SNSLoginProtocol <NSObject>

- (void)loginWithContext:(UIViewController *)context
                 success:(ObjectBlock)successHandler
                 failure:(ErrorBlock)failureHandler;

@end

NS_ASSUME_NONNULL_END
