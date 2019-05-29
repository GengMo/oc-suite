#import "UINavigationController+Extension.h"
#import "UIViewController+Extension.h"

@implementation UINavigationController (AutomaticallyDismissKeyboard)

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

@end

@implementation UINavigationController (Finder)

- (UIViewController *)topmostViewController {
    if (self.presentedViewController) {
        return self.presentedViewController.topmostViewController;
    }
    
    return self.viewControllers.lastObject.topmostViewController ?: self;
}

- (UIViewController *)viewControllerForClass:(Class)cls {
    for (id vc in self.viewControllers) {
        if ([vc isKindOfClass:cls]) {
            return vc;
        }
    }
    
    return nil;
}

@end
