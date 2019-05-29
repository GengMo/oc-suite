#import <UIKit/UIKit.h>

@interface UIButton ( Convenience )

/**
 * 设置颜色
 
 * 状态：默认态、高亮态
 */

- (void)setTitleColor:(UIColor *)color;

- (void)setTitleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor;

/**
 * 设置背景色
 
 * 用image去实现
 */

- (void)setNormalBackgroundColor:(UIColor *)normalColor disableBackgroundColor:(UIColor *)disableColor;

/**
 *  设置不同状态的背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

#pragma mark - Enlarge - inspire by http://blog.csdn.net/jerry19860710/article/details/22800309

/**
 *  Usage
 
 UIButton* enlargeButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 [enlargeButton1 setTitle:@"Enlarge Button" forState:UIControlStateNormal];
 [enlargeButton1 setFrame:CGRectMake(90, 150, 100, 50)];
 [enlargeButton1 addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
 [enlargeButton1 sizeToFit];
 [self.view addSubview:enlargeButton1];
 
 // 增加 button 的點擊範圍
 [enlargeButton1 setEnlargeEdgeWithTop:20 right:20 bottom:20 left:0];
 
 */
@interface UIButton ( Enlarge )

/**
 *  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/**
 *  扩大button点击区域,4边设置相同值
 */
@property (nonatomic, assign) CGFloat enlargedEdge;

/**
 *  扩大button点击区域,4边分别设置
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                         left:(CGFloat)left
                       bottom:(CGFloat)bottom
                        right:(CGFloat)right;

@end

//https://github.com/Phelthas/Demo_ButtonImageTitleEdgeInsets
// 用button的titleEdgeInsets和 imageEdgeInsets属性来实现button文字图片上下或者左右排列的
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonImagePosition) {
    UIButtonImagePositionLeft = 0,              //图片在左，文字在右，默认
    UIButtonImagePositionRight = 1,             //图片在右，文字在左
    UIButtonImagePositionTop = 2,               //图片在上，文字在下
    UIButtonImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton ( ImagePosition )

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(UIButtonImagePosition)postion spacing:(CGFloat)spacing;

@end

