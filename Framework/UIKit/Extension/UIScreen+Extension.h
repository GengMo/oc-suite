#import <UIKit/UIKit.h>

@interface UIScreen (Extension)

- (CGRect)currentBounds;
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;

- (BOOL)isRetinaDisplay;

+ (CGFloat)width;
+ (CGFloat)height;
+ (CGSize)size;

+ (CGSize)orientationSize;
+ (CGFloat)orientationWidth;
+ (CGFloat)orientationHeight;

+ (CGSize)DPISize;

@end
