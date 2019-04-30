
#import "_Foundation.h"
//#import "Masonry.h"
#import "UIView+Extension.h"
#import "BaseViewController.h"
#import "BaseViewController+Private.h"
#import "UIViewController+Extension.h"

// ----------------------------------
// class implementation
// ----------------------------------

@interface BaseViewController ()

@property (nonatomic, copy) UIColor *originNavBarColor;
@property (nonatomic, copy) UIColor *originNavTitleColor;

@property (nonatomic, assign) BOOL hasPreferNavBarColor;
@property (nonatomic, assign) BOOL hasPreferNavTitleColor;

@property (nonatomic, assign) BOOL alreadyInitialized;

@end

@implementation BaseViewController

@def_prop_class( UIColor *, preferredNavigationBarColor, setPreferredNavigationBarColor )
@def_prop_class( UIStatusBarStyle, userPreferredStatusBarStyle, setUserPreferredStatusBarStyle )
@def_prop_class( UIColor *, preferredViewBackgroundColor, setPreferredViewBackgroundColor )

@def_prop_class( NSString *,    backButtonImageName, setBackButtonImageName )

@def_prop_assign( BOOL,         hideKeyboardWhenEndEditing )
@def_prop_assign( BOOL,         statusBarHidden )

@def_prop_assign( BOOL,         navbarHiddenWhenAppear )
@def_prop_assign( BOOL,         navbarHiddenWhenDisappear )
@def_prop_assign( BOOL,         navbarLeftButtonHiddenWhenAppear )

@def_prop_strong( UIColor *,    navbarBackgroundColor )
@def_prop_strong( UIColor *,    navbarNormalTitleColor )

@def_prop_readonly( id,         topViewController )
@def_prop_readonly( BOOL,       isVisible )
@def_prop_readonly( BOOL,       isNavigationRootController )

- (UIViewController *)topViewController {
    UIViewController *viewController = [self topViewControllerOfViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (viewController.presentedViewController) {
        viewController = [self topViewControllerOfViewController:viewController.presentedViewController];
    }
    return viewController;
}

- (UIViewController *)topViewControllerOfViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [self topViewControllerOfViewController:[(UINavigationController *)viewController topViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [self topViewControllerOfViewController:[(UITabBarController *)viewController selectedViewController]];
    } else {
        return viewController;
    }
    return nil;
}

- (BOOL)isNavigationRootController {
    if (!self.navigationController ||
        !self.navigationController.viewControllers ||
        ![self.navigationController.viewControllers count]) {
        return YES;
    }
    
    return [self.navigationController.viewControllers.firstObject isEqual:self];
}

- (BOOL)isVisible { return (self.isViewLoaded && self.view.window); }

#pragma mark - Initialize

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefault];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initDefault];
    }
    return self;
}

- (id)initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)controller {
    return [self controllerWithNibName:NSStringFromClass([self class])];
}

+ (instancetype)controllerWithNibName:(NSString *)nibName {
    return [[self alloc] initWithNibName:nibName bundle:nil];
}

- (void)initDefault {
    if (self.alreadyInitialized) {
        return;
    }
    self.alreadyInitialized = YES;
    
    [self hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {

    } error:nil];
    
    self.hideKeyboardWhenEndEditing = YES;
    self.statusBarHidden = NO;
    self.navbarHiddenWhenAppear = NO;
    self.navbarHiddenWhenDisappear = NO;
    self.navbarLeftButtonHiddenWhenAppear = NO;
    self.navbarNormalTitleColor = nil;
    
    self.navbarBackgroundColor = self.class.preferredNavigationBarColor;
}

// MARK: - MVVM

- (instancetype)initWithViewModel:(id)viewModel {
    if (self = [super init]) {
        [self initDefault];
    }
    
    return self;
}

- (void)bindViewModel:(id)viewModel { }

- (void)bindViewModel { }

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏返回按钮
    if (![self isNavigationRootController] &&
        self.class.backButtonImageName) {
        [self setNavLeftItemWithImage:self.class.backButtonImageName target:self action:@selector(onBack)];
    }

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 隐藏导航栏返回按钮
    if (self.navbarLeftButtonHiddenWhenAppear) {
        [self clearNavLeftItem];
    }
    
    if (self.class.preferredViewBackgroundColor)
        self.view.backgroundColor = self.class.preferredViewBackgroundColor;
    
#if 0 // 切换tab的时候动画
    [self injectSwipeToTabGesture];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    SEL selector = @selector(navbarHiddenWhenAppear);
//    BOOL overrided = [self.class instanceMethodForSelector:selector] != [BaseViewController.class instanceMethodForSelector:selector];
    
    if (self.navbarHiddenWhenAppear) {
        [self.navigationController setNavigationBarHidden:self.navbarHiddenWhenAppear animated:animated];
    }
    
    UIColor *preferNavBarColor = self.navbarBackgroundColor;
    if (preferNavBarColor) {
        self.hasPreferNavBarColor = YES;
        self.originNavBarColor = self.navBarColor;
        self.navBarColor = preferNavBarColor;
    }
    
    UIColor *preferNavBarNormalTitleColor = self.navbarNormalTitleColor;
    if (preferNavBarNormalTitleColor) {
        self.hasPreferNavTitleColor = YES;
        self.originNavTitleColor = self.navTitleColor;
        
        self.navTitleColor = preferNavBarNormalTitleColor;
        self.navLeftItemNormalTitleColor = preferNavBarNormalTitleColor;
        self.navRightItemNormalTitleColor = preferNavBarNormalTitleColor;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 解决手势返回失效的问题
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navbarHiddenWhenDisappear) {
        [self.navigationController setNavigationBarHidden:self.navbarHiddenWhenDisappear animated:animated];
    }
    
    if (self.hasPreferNavBarColor) {
        self.navBarColor = self.originNavBarColor;
    }
    
    if (self.hasPreferNavTitleColor) {
        self.navTitleColor = self.originNavTitleColor;
        self.navLeftItemNormalTitleColor = self.originNavBarColor;
        self.navRightItemNormalTitleColor = self.originNavBarColor;
    }
}

- (void)dealloc {
    [self unobserveAllNotifications];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.hideKeyboardWhenEndEditing) {
        [self.view endEditing:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: - Constraints

- (void)applyViewConstraints { }

- (void)updateViewConstraints { [super updateViewConstraints]; }

#pragma mark - Status style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.class.userPreferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden {
    _statusBarHidden = statusBarHidden;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

// MARK: - tabbed switch

- (void)injectSwipeToTabGesture {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
}

- (void)tappedRightButton:(id)sender {
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    NSArray *aryViewController = self.tabBarController.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        UIView *fromView = [self.tabBarController.selectedViewController view];
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                [self.tabBarController setSelectedIndex:selectedIndex + 1];
            }
        }];
    }
}

- (void)tappedLeftButton:(id)sender {
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    if (selectedIndex > 0) {
        UIView *fromView = [self.tabBarController.selectedViewController view];
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
            }
        }];
    }
}

@end

#pragma mark - Navigation control

@implementation BaseViewController ( NavigationControl )

- (void)push:(UIViewController *)viewController animate:(BOOL)animate {
    [self.navigationController pushViewController:viewController animated:animate];
}

- (void)push:(UIViewController *)viewController {
    [self push:viewController animate:YES];
}

- (void)pop:(BOOL)animate {
    [self.navigationController popViewControllerAnimated:animate];
}

- (void)pop {
    [self pop:YES];
}

- (void)popTo:(UIViewController *)viewController animate:(BOOL)animate {
    [self.navigationController popToViewController:viewController animated:animate];
}

- (void)popTo:(UIViewController *)viewController {
    [self popTo:viewController animate:YES];
}

- (void)popToRoot:(BOOL)animate {
    [self.navigationController popToRootViewControllerAnimated:animate];
}

- (void)popToRoot {
    [self popToRoot:YES];
}

- (void)present:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
