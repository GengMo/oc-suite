#import <UIKit/UIKit.h>
#import "UIImage+Extension.h"

@interface UIImageView ( WaterMark )

// 图片水印
- (void)setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;

// 文字水印
- (void)setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

- (void)setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end

// MARK: - Shape

@interface UIImageView (shape)

@property (nonatomic, strong) CALayer *contentLayer;

- (void)shapeWithPath:(CGPathRef)path;

- (void)setShapedImage:(UIImage *)image;

@end


