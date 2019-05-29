#import <UIKit/UIKit.h>

/**
 *  @knowledge
 
 *  加约束的时候，label 高度一定，可以不设置宽度，会更根据内容自动填充；宽度一定（leading trailiing），可以不设置高度，会自动换行填充。
 */

@interface UILabel ( Convenience )

+ (instancetype)instance;
+ (instancetype)instanceWithFont:(UIFont *)font color:(UIColor *)color;
+ (instancetype)instanceWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

+ (UILabel *)cornerLabel:(UIColor *)bgColor;

- (void)setAttributedText:(NSString *)originText withKeyText:(NSString *)keyText keyTextColor:(UIColor *)textColor;

@end

#pragma mark -

@interface UILabel ( ContentSize )

- (CGFloat)heightWithLimitWidth:(CGFloat)width;

- (int)lineCountWithLimitWidth:(CGFloat)width;

- (CGFloat)heightWithLineSpace:(CGFloat)space value:(NSString *)value font:(UIFont *)font width:(CGFloat)width;

- (BOOL)isTruncated;

- (CGFloat)sizeToFitWithMaximumNumberOfLines:(NSInteger)lines;
- (CGSize)sizeOfSizeToFitWithMaximumNumberOfLines:(NSInteger)lines;

@end

#pragma mark - Line spacing

@interface UILabel ( LineSpacing )

- (void)setLineSpace:(CGFloat)space withValue:(NSString *)value withFont:(UIFont *)font;

@end
