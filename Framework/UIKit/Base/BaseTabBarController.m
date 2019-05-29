#import "UIViewController+Extension.h"
#import "BaseTabBarController.h"
#import "_Geometry.h"
#import "_Frame.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

// MARK: - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavLeftItemWithImage:@"top_backbutton" target:self action:@selector(onBack)];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    /**
     *  inspired by http://www.jianshu.com/p/f334cbaa41bf
     */
    if (self.isTabBarHeightCustomized) {
        CGRectSetHeight(self.tabBar.frame, self.tabBarHeight);
    }
//    [self.tabBar bringSubviewToFront:self.bottomToolView];
}

// MARK: -

- (void)onBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: - Status style

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
