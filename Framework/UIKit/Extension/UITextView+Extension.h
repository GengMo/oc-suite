#import <UIKit/UIKit.h>

#pragma mark - 占位

@interface UITextView ( Placeholder )

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end

#pragma mark - 字符数限制

@interface UITextView ( InputLimit )

@property (assign, nonatomic)  NSInteger maxLength;//if <=0, no limit

@end

#pragma mark - 

/*
 UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
 [self.view addSubview:textView];
 textView.zoomEnabled = YES;
 textView.minFontSize = 10;
 textView.maxFontSize = 40;
 */

@interface UITextView ( PinchZoom )

@property (nonatomic) CGFloat maxFontSize, minFontSize;

@property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;

@end

#pragma mark - 选择

@interface UITextView ( Select )

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange;

/**
 *  @brief  选中所有文字
 */
- (void)selectAllText;

/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)setSelectedRange:(NSRange)range;

//https://github.com/pclion/TextViewCalculateLength
// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)getInputLengthWithText:(NSString *)text;

@end


