#import <UIKit/UIKit.h>
#import <Framework/_Foundation.h>

#pragma mark - 视图关系

@interface UIView ( Extension )

- (NSUInteger)getSubviewIndex;

- (void)bringToFront;
- (void)sendToBack;

- (void)bringOneLevelUp;
- (void)sendOneLevelDown;

- (BOOL)isInFront;
- (BOOL)isAtBack;
- (BOOL)isDisplayedInScreen;

- (void)swapDepthsWithView:(UIView*)swapView;

- (UIView *)subviewWithTag:(NSUInteger)tag;
- (void)removeAllSubviews;
- (void)removeSubViewByTag:(NSUInteger)tag;
- (void)removeSubViewWithClassType:(Class)classt;
- (void)removeSubViews:(NSArray *)views;

- (BOOL)containsSubView:(UIView *)subView;
- (BOOL)containsSubViewOfClassType:(Class)classt;

- (UIView *)firstSubviewOfClass:(Class)classObj; // 按类型取第一个子视图（所有层次，深度优先，不包含自身）
- (NSMutableArray *)allViewOfClass:(Class)viewClass; // 按类型过滤所有视图（所有层次，深度优先，包含自身）

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (id)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;
- (id)findSuperViewWithSuperViewClass:(Class)clazz; // 找到指定类名的SuperView对象

- (void)runBlockOnAllSubviews:(ObjectBlock)block;
- (void)runBlockOnAllSuperviews:(ObjectBlock)block;
- (void)enableAllControlsInViewHierarchy;
- (void)disableAllControlsInViewHierarchy;

- (BOOL)findAndResignFirstResponder; // 找到并且resign第一响应者
- (UIView *)findFirstResponder; // 找到第一响应者
- (UIViewController *)firstTopViewController;
@property (readonly) UIViewController *viewController; //找到当前view所在的viewcontroler

@end

#pragma mark - 图片

@interface UIView ( Image )

/**
 *  生成UIView的UIImage
 *
 *  @return UIImage
 */
- (UIImage *)imageRepresentation;

- (UIImage *)image;

- (UIImage *)imageWithRect:(CGRect)rect;

- (UIImageOrientation)imageOrientationWithScreenOrientation;

@end

#pragma mark - 配置

@interface UIView (Layer)

// 设置边框
- (void)setBorderWidth:(CGFloat)width;

- (void)setBorderColor:(UIColor *)color;

- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color;

// 圆角
- (void)circular:(CGFloat)radius;
- (void)circularWithoutCrop:(CGFloat)radius;

/**
 *  四个边角分别加远角
 *
 *  @param radius 半径
 *  @param type UIRectCornerTopLeft|UIRectCornerTopRight
 */
- (void)circular:(CGFloat)radius rectCorner:(UIRectCorner)type;

// 圆角 : 默认 4 像素
- (void)circularCorner;

// 圆形 : 默认使用当前高度计算
// +able, 因为可能是圆的，也可能需要根据实时计算
- (void)circulable;

// 阴影 : 默认 4 像素
- (void)shadowable;

- (void)shadeBottomWithOffset:(CGFloat)offset;

- (void)shadeTop;
- (void)shadeBottom;

- (void)shadeAround; // 四周加阴影
- (void)shadeAroundwithColor:(UIColor *)color depth:(CGFloat)depth;

@end

/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, JKExcludePoint) {
    JKExcludeStartPoint = 1 << 0,
    JKExcludeEndPoint = 1 << 1,
    JKExcludeAllPoint = ~0UL
};


@interface UIView ( CustomBorder )

- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)removeTopBorder;
- (void)removeLeftBorder;
- (void)removeBottomBorder;
- (void)removeRightBorder;


- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
@end

@interface UIView ( Screenshot )
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)screenshot;

- (UIImage *)takeSnapshot;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)screenshot:(CGFloat)maxWidth;

@end

typedef void (^UIGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (Action)

/**
 *  onXXXXXX: (UITapGestureRecognizer *)rec
 */
- (void)addTapGestureWithTarget:(id)target action:(SEL)action;

- (void)addTapGestureWithTarget:(id)target action:(SEL)action acceptEventInterval:(NSTimeInterval)interval;

/**
 *  onXXXXXX: (UITapGestureRecognizer *)rec
 */
- (void)addDoubleTapGestureWithTarget:(id)target action:(SEL)action;

/**
 *  onXXXXXX: (UIPanGestureRecognizer *)rec
 */
- (void)addPanGestureWithTarget:(id)target action:(SEL)action;

/**
 *  onXXXXXX: (UILongPressGestureRecognizer *)rec
 *
 *  rec.state, UIGestureRecognizerStateBegan, UIGestureRecognizerStateChanged, UIGestureRecognizerStateEnded
 */
- (void)addLongPressGestureWithTarget:(id)target action:(SEL)action;

/**
 *  @brief  添加tap手势
 */
- (void)addTapActionWithBlock:(UIGestureActionBlock)block;

/**
 *  @brief  添加长按手势
 */
- (void)addLongPressActionWithBlock:(UIGestureActionBlock)block;

@end
