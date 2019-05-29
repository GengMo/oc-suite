#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

/**
 *  自定义tab bar的高度
 */
@property (nonatomic, assign) BOOL isTabBarHeightCustomized;
@property (nonatomic, assign) CGFloat tabBarHeight;

#pragma mark - Override methods

- (void)onBack;

@end
