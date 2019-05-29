#import "UIScrollView+Extension.h"

#pragma mark -

@implementation UIScrollView ( Convenience )

+ (instancetype)instance {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;
    
    return scrollView;
}

@end
