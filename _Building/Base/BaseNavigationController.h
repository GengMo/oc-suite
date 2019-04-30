#import <UIKit/UIKit.h>
#import <_Foundation/_Foundation.h>

@interface BaseNavigationController : UINavigationController

@prop_assign( BOOL,         autoHideBottomBar )         // [YES]

#pragma mark - Style config

- (void)configNavigationBar:(void (^)(UINavigationBar *bar))handler;

@end
