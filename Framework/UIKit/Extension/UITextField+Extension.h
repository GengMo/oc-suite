#import <UIKit/UIKit.h>
#import <Framework/_Foundation.h>

#pragma mark -

@interface UITextField ( CursorOffset )

- (CGFloat)cursorOffset;

@end

#pragma mark -

@interface UITextField ( InputLimit )

@prop_dynamic( NSNumber *, maxLength ) // [Max] as NSUInteger
@prop_dynamic( NSNumber *, chnDoubled ) // [NO] as BOOL, If YES, then length(@"我") = 2

@end


#pragma mark -

@interface UITextField ( ExtentRange )

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

/**
 *  @brief  选中所有文字
 */
- (void)selectAllText;

@end

#pragma mark - Block

@interface UITextField ( Blocks )

@property (copy, nonatomic) BOOL (^shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldClearBlock)(UITextField *textField);

- (void)setShouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setShouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setDidBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setDidEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setShouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setShouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;

@end
