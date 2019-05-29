#import <UIKit/UIKit.h>

@interface UINavigationController (AutomaticallyDismissKeyboard)

@end

@interface UINavigationController (Finder)

@property (nonatomic, readonly) UIViewController *topmostViewController;

- (UIViewController *)viewControllerForClass:(Class)cls;

@end
