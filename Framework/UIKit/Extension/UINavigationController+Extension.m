#import "UINavigationController+Extension.h"
#import "UIViewController+Extension.h"

@implementation UINavigationController (AutomaticallyDismissKeyboard)

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

@end

@implementation UINavigationController (Finder)

- (UIViewController *)topMostViewController {
    if (self.presentedViewController) {
        return self.presentedViewController.topMostViewController;
    }
    
    return self.viewControllers.lastObject.topMostViewController ?: self;
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
