#import <UIKit/UIKit.h>

@interface UIResponder ( Extension )

/**
 *  @brief  响应者链
 */
- (NSString *)responderChainDescription;

/**
 *  @brief  当前第一响应者
 */
+ (id)currentFirstResponder;

@end
