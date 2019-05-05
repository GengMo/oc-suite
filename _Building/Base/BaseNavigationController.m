#import "BaseNavigationController.h"
#import "BaseNavigationBar.h"
#import "UIImage+Extension.h"

typedef void (^ _TransitionBlock)(void);

@interface BaseNavigationController () <UINavigationControllerDelegate> {
    BOOL _transitionInProgress;
    NSMutableArray *_paddingBlocks;
    CGFloat _systemVersion;
}

@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@implementation BaseNavigationController

@def_prop_assign( BOOL,         autoHideBottomBar )

// MARK: - Initialize

- (instancetype)init {
    if (self = [super initWithNavigationBarClass:[BaseNavigationBar class] toolbarClass:nil]) {
        [self initDefault];
    }
    
    return self;
}

+ (void)initialize {
    
    if (@available(iOS 9.0, *)) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        // 设置导航条前景色
        [bar setTintColor:[UIColor blackColor]];
        
        
//        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//        // 修改返回按钮标题的位置
//        [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -900) forBarMetrics:UIBarMetricsDefault];
    } else {
        // Fallback on earlier versions
    }
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithNavigationBarClass:[BaseNavigationBar class] toolbarClass:nil]) {
        self.viewControllers = @[rootViewController];
        
        [self initDefault];
    }
    
    return self;
}

- (void)initDefault {
    // To override the opacity of CRNavigationBar's barTintColor, set this value to YES.
    ((BaseNavigationBar *)self.navigationBar).overrideOpacity = NO;
    
    _transitionInProgress = NO;
    _paddingBlocks = [NSMutableArray arrayWithCapacity:2];
    _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    _autoHideBottomBar = YES;
}

// MARK: -

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0 &&
        self.autoHideBottomBar) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    return [super pushViewController:viewController animated:animated];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color alpha:(CGFloat)alpha  {
    if (alpha >= 1) {
        [self.navigationBar setTranslucent:NO];
    } else {
        [self.navigationBar setTranslucent:YES];
    }
    
    UIImage *image = [UIImage imageWithColor:[color colorWithAlphaComponent:alpha]];
    [self.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

// MARK: -

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [[self topViewController] prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [[self topViewController] preferredStatusBarUpdateAnimation];
}

@end
