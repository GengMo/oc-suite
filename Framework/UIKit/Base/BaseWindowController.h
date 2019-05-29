#import <UIKit/UIKit.h>

@interface BaseWindowController : UIViewController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyleToSet;

+ (BaseWindowController *)createWindowControllerWithStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

@end
