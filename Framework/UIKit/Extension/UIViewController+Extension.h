#import <UIKit/UIKit.h>

@interface UIViewController ( Extension )

@property (nonatomic, strong) NSString *navTitleString;
@property (nonatomic, strong) UIView *navTitleView;

@property (nonatomic, strong) UIColor *navBarColor;     //改变导航栏背景颜色
@property (nonatomic, strong) UIColor *navTitleColor;   //改变导航栏标题颜色
@property (nonatomic, strong) UIColor *navLeftItemNormalTitleColor;     //改变导航栏左边按钮的Normal状态标题颜色
@property (nonatomic, strong) UIColor *navRightItemNormalTitleColor;    //改变导航栏右边按钮的Normal状态标题颜色
@property (nonatomic, strong) UIColor *navItemHighlightedTitleColor;    //改变导航栏左边按钮、右边按钮的Highlighted状态标题颜色

- (void)clearNavLeftItem;
- (void)setNavLeftItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action;
- (void)setNavLeftItemWithName:(NSString *)name font:(UIFont *)font target:(id)target action:(SEL)action;

- (void)setNavRightItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action;
- (void)setNavRightItemWithName:(NSString *)name font:(UIFont *)font target:(id)target action:(SEL)action;

- (void)setNavLeftItemWithButton:(UIButton *)button target:(id)target action:(SEL)action;
- (void)setNavRightItemWithButton:(UIButton *)button target:(id)target action:(SEL)action;

- (void)setNavLeftItemWithView:(UIView *)view target:(id)target action:(SEL)action;
- (void)setNavRightItemWithView:(UIView *)view target:(id)target action:(SEL)action;

// 属性设置

- (void)setNavLeftItemHidden:(BOOL)hidden animate:(BOOL)animate;
- (void)setNavRightItemHidden:(BOOL)hidden animate:(BOOL)animate;

// frame 修改

- (void)setNavigationBarTitleVerticalPositionAdjustmentOffset:(CGFloat)verticalOffset;
- (void)setNavigationBarTitleVerticalPositionAdjustmentOffsetDefault;

- (void)setNavigationBarBackButtonVerticalPositionAdjustmentOffset:(CGFloat)verticalOffset;
- (void)setNavigationBarBackButtonVerticalPositionAdjustmentOffsetDefault;

/**
 *  设置导航栏高度，一般在viewWillAppear中调用
 */
- (void)setNavigationBarHeight:(CGFloat)height;
- (void)setNavigationBarHeightDefault;

@property (nonatomic, readonly) UIViewController *topMostViewController;

@end

