
#import <Framework/_Foundation.h>

typedef void(^ _CountDownProgressBlock)(NSTimeInterval timeLeft);
typedef void(^ _CountDownCompletionBlock)(void);
/**
 * @brief 倒计时
 */
@interface _CountDown : NSObject

@prop_readonly( NSTimeInterval, collapsedTime ) // As Second
@prop_readonly( NSTimeInterval, leftTime )  // As Second

@prop_assign( NSTimeInterval, interval )    // [1] As Second

/**
 * @brief 初始化倒计时器
 */
- (instancetype)initWithDuration:(NSTimeInterval)duration; // Per Second

/**
 * @brief 设置剩余时间，需要手动重启
 */
- (void)setDuration:(NSTimeInterval)duration;

/**
 * @brief 开始倒计时
 */
- (void)start:(_CountDownProgressBlock)currentBlock;
- (void)start:(_CountDownProgressBlock)currentBlock completion:(_CountDownCompletionBlock)completion;

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
