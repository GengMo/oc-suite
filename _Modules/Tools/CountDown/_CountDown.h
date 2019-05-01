
#import <_Foundation/_Foundation.h>

/**
 * @brief 倒计时
 */
@interface _CountDown : NSObject

@prop_readonly( NSTimeInterval, leftTime ) // Per Second
@prop_readonly( BOOL, paused )

/**
 * @brief 初始化倒计时器
 */
- (instancetype)initWithInterval:(NSTimeInterval)timeLeft; // Per Second

/**
 * @brief 设置剩余时间，需要手动重启
 */
- (void)setLeftTime:(NSTimeInterval)leftTime;

/**
 * @brief 开始倒计时
 */
- (void)start:(void(^)(NSTimeInterval timeLeft))currentBlock;
- (void)start:(void(^)(NSTimeInterval timeLeft))currentBlock completion:(void(^)(void))completion;

/**
 * @brief 暂停倒计时器
 */
- (void)pause;

/**
 * @brief 恢复倒计时器
 */
- (void)resume;

/**
 * @brief 停止倒计时器
 */
- (void)stop;

@end
