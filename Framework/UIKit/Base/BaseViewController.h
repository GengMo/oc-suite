//
//  BaseViewController.h
// fallen.ink
//
//  Created by 李杰 on 4/27/15.
//
//

#import <Framework/_Foundation.h>

#pragma mark -

@interface BaseViewController : UIViewController

@prop_class( UIColor *,     preferredNavigationBarColor )
@prop_class( UIStatusBarStyle, userPreferredStatusBarStyle )
@prop_class( UIColor *,     preferredViewBackgroundColor )

@prop_class( NSString *,    backButtonImageName )

@prop_assign( BOOL,         hideKeyboardWhenEndEditing )      // [YES]
@prop_assign( BOOL,         statusBarHidden )                 // [NO]

@prop_assign( BOOL,         navbarHiddenWhenAppear )          // [NO] 应该在[super initDefault] 后设置
@prop_assign( BOOL,         navbarHiddenWhenDisappear )       // [NO]
@prop_assign( BOOL,         navbarLeftButtonHiddenWhenAppear )// [NO]

@prop_strong( UIColor *,    navbarBackgroundColor )           // [nil]
@prop_strong( UIColor *,    navbarNormalTitleColor )          // [nil]

@prop_readonly( id,         topViewController )
@prop_readonly( BOOL,       isVisible )
@prop_readonly( BOOL,       isNavigationRootController )

+ (instancetype)controller;
+ (instancetype)controllerWithNibName:(NSString *)nibName;

- (id)initWithNib;

// MARK: - MVVM Templates

- (instancetype)initWithViewModel:(id)viewModel;

- (void)bindViewModel;
- (void)bindViewModel:(id)viewModel;

// MARK: - Constraints

- (void)applyViewConstraints; // 在viewDidLoad尾调用，推荐：Masonry, SBLayout
- (void)updateViewConstraints; // 更新约束

- (void)onBack;

@end

#pragma mark - Navigation control

@interface BaseViewController ( NavigationControl )

- (void)push:(UIViewController *)viewController animate:(BOOL)animate;
- (void)push:(UIViewController *)viewController;

- (void)pop:(BOOL)animate;
- (void)pop;
- (void)popTo:(UIViewController *)viewController animate:(BOOL)animate;
- (void)popTo:(UIViewController *)viewController;

- (void)popToRoot:(BOOL)animate;
- (void)popToRoot;

/**
 *  转场动画
 *  vc.modalTransitionStyle configuration
 *  typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
        UIModalTransitionStyleCoverVertical = 0,
        UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED, 水平翻转
        UIModalTransitionStyleCrossDissolve,
        UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED, 向上翻页效果
    };
 */
- (void)present:(UIViewController *)viewController;
- (void)dismiss;

@end

