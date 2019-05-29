#import <UIKit/UIKit.h>

@interface UIResponder ( Chain )

/**
 *  @brief  响应者链
 */
- (NSString *)responderChainDescription;

@end

@interface UIResponder ( FirstResponder )
/**
 *  @brief  当前第一响应者
 */
+ (id)currentFirstResponder;

@end
