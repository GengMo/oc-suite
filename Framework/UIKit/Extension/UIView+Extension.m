#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "_Geometry.h"
#import "_Frame.h"
#import "_Foundation.h"
#import "UIView+Extension.h"

#pragma mark - 视图关系

@implementation UIView ( Extension )

- (NSUInteger)getSubviewIndex {
    return [self.superview.subviews indexOfObject:self];
}

- (void)bringToFront {
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
    [self.superview sendSubviewToBack:self];
}

- (void)bringOneLevelUp {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

- (void)sendOneLevelDown {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

- (BOOL)isInFront {
    return ([self.superview.subviews lastObject]==self);
}

- (BOOL)isAtBack {
    return ([self.superview.subviews objectAtIndex:0]==self);
}

- (BOOL)isDisplayedInScreen {
    if (self == nil) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    // 若 view 隐藏
    if (self.hidden) {
        return NO;
    }
    
    // 若没有 superview
    if (self.superview == nil) {
        return NO;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  NO;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

- (void)swapDepthsWithView:(UIView*)swapView {
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

- (void)removeAllSubviews {
    // Normally.
    //    for(UIView *view in [self subviews]) {
    //        [view removeFromSuperview];
    //    }
    
    // But others.
    //    [self setSubviews:[NSArray array]]; // If subviews can be written.
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (UIView *)subviewWithTag:(NSUInteger)tag {
    __block UIView *v = nil;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((v = [obj viewWithTag:tag])) {
            
            
            *stop = true;
        }
    }];
    
    return v;
}

- (void)removeSubViewByTag:(NSUInteger)tag {
    UIView *v = nil;
    if ((v = [self viewWithTag:tag])) {
        [v removeFromSuperview];
    }
}

- (void)removeSubViewWithClassType:(Class)classt {
    NSArray *allSubviews = [self subviews];
    
    for (UIView *view in allSubviews) {
        if ([view isMemberOfClass:classt]) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeSubViews:(NSArray *)views {
    if (views && [views count]) {
        [views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

- (BOOL)containsSubView:(UIView *)subView {
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsSubViewOfClassType:(Class)classt {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:classt]) {
            return YES;
        }
    }
    return NO;
}

- (UIView*)firstSubviewOfClass:(Class)classObj {
    NSMutableArray* allViews = [self allViewOfClass:classObj];
    [allViews removeObject:self];
    return allViews.count == 0 ? nil : allViews[0];
}

// 递归查找所有子视图（包含自身）
- (void)findAllViewWithRootView:(UIView *)rootView resultArray:(NSMutableArray*)resultArray {
    if (rootView == nil) {
        return;
    }
    [resultArray addObject:rootView];
    for (UIView *aview in [rootView subviews]){
        [self findAllViewWithRootView:aview resultArray:resultArray];
    }
}

- (NSMutableArray*)allViewOfClass:(Class)viewClass {
    NSMutableArray* resultArray = [NSMutableArray new];
    [self findAllViewWithRootView:self resultArray:resultArray];
    if (viewClass) {
        NSMutableArray* filteredArray = [NSMutableArray new];
        for (UIView* view in resultArray) {
            if ([view isMemberOfClass:viewClass]) {
                [filteredArray addObject:view];
            }
        }
        return filteredArray;
    } else {
        return resultArray;
    }
}

- (UIViewController*)firstTopViewController {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    for (UIResponder* responder = self.nextResponder; responder != window; responder = responder.nextResponder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
    }
    return nil;
}

#pragma mark - 

- (id)findSubViewWithSubViewClass:(Class)clazz {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    
    return nil;
}

- (id)findSuperViewWithSuperViewClass:(Class)clazz {
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:clazz]) {
        return self.superview;
    } else {
        return [self.superview findSuperViewWithSuperViewClass:clazz];
    }
}

- (void)runBlockOnAllSubviews:(ObjectBlock)block {
    block(self);
    for (UIView *view in [self subviews]) {
        [view runBlockOnAllSubviews:block];
    }
}

- (void)runBlockOnAllSuperviews:(ObjectBlock)block {
    block(self);
    if (self.superview) {
        [self.superview runBlockOnAllSuperviews:block];
    }
}

- (void)enableAllControlsInViewHierarchy {
    [self runBlockOnAllSubviews:^(UIView *view) {
        if ([view isKindOfClass:[UIControl class]]) {
            [(UIControl *)view setEnabled:YES];
        } else if ([view isKindOfClass:[UITextView class]]) {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

- (void)disableAllControlsInViewHierarchy  {
    [self runBlockOnAllSubviews:^(UIView *view) {
        if ([view isKindOfClass:[UIControl class]]) {
            [(UIControl *)view setEnabled:NO];
        } else if ([view isKindOfClass:[UITextView class]]) {
            [(UITextView *)view setEditable:NO];
        }
    }];
}

- (BOOL)findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    
    for (UIView *v in self.subviews) {
        if ([v findAndResignFirstResponder]) {
            return YES;
        }
    }
    
    return NO;
}

- (UIView *)findFirstResponder {
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v findFirstResponder];
        if (fv) {
            return fv;
        }
    }
    
    return nil;
}

- (UIViewController *)viewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}


@end

#pragma mark - 图片

@implementation UIView ( Image )

- (UIImage *)imageRepresentation {
    int width = CGRectGetWidth([self bounds]);
    int height = CGRectGetHeight([self bounds]);
    
    NSInteger myDataLength = width * height * 4;
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y <height; y++) {
        for(int x = 0; x <width * 4; x++) {
            buffer2[(height - 1 - y) * width * 4 + x] = buffer[y * 4 * width + x];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

- (UIImage *)image {
    CGSize  layerSize = self.layer.frame.size;
    CGFloat scale     = screen_scale;
    CGFloat opaque    = NO;
    UIGraphicsBeginImageContextWithOptions(layerSize, opaque, scale);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage *)imageWithRect:(CGRect)rect {
    CGFloat scale = screen_scale;
    UIImage *screenshot = [self image];
    rect = CGRectMakeScale(rect, scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], rect);
    UIImage *croppedScreenshot = [UIImage imageWithCGImage:imageRef
                                                     scale:screenshot.scale
                                               orientation:screenshot.imageOrientation];
    CGImageRelease(imageRef);
    
    UIImageOrientation imageOrientation = [self imageOrientationWithScreenOrientation];
    return [[UIImage alloc] initWithCGImage:croppedScreenshot.CGImage
                                      scale:croppedScreenshot.scale
                                orientation:imageOrientation];
}

- (UIImageOrientation)imageOrientationWithScreenOrientation {
    UIInterfaceOrientation orientation = status_bar_orientation;
    UIImageOrientation imageOrientation = UIImageOrientationUp;
    
    switch (orientation) {
        case UIDeviceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationDown;
            break;
        case UIDeviceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationRight;
            break;
        case UIDeviceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationLeft;
            break;
        default:
            break;
    }
    return imageOrientation;
}

@end

#pragma mark - 配置

@implementation UIView (Layer)

- (void)setBorderWidth:(CGFloat)width {
    if (width) {
        self.layer.borderWidth  = width;
    }
}

- (void)setBorderColor:(UIColor *)color {
    if (color) {
        self.layer.borderColor = [color CGColor];
    }
}

- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color {
    [self setBorderWidth:width];
    [self setBorderColor:color];
}

// 圆角
- (void)circular:(CGFloat)radius {
    [[self layer] setCornerRadius:radius];
    [[self layer] setMasksToBounds:YES];
}

- (void)circularWithoutCrop:(CGFloat)radius {
    [self.layer setCornerRadius:radius];
}

- (void)circular:(CGFloat)radius rectCorner:(UIRectCorner)type {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:type
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    
    [self setNeedsDisplay];
}

// 主题圆角：4.0
- (void)circularCorner {
    [self circular:PIXEL_4];
}

- (void)circulable {
    [self circular:MIN(self.width, self.height) / 2];
}

- (void)shadeBottomWithOffset:(CGFloat)offset {
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, offset);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)shadowable {
//    TODO("该接口有问题")
    [self shadeBottomWithOffset:4];
}

- (void)shadeTop {
    self.layer.masksToBounds = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.75;
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shouldRasterize = YES; // 设置缓存
    self.layer.rasterizationScale = [UIScreen mainScreen].scale; // 设置抗锯齿边缘
    
    CGSize size = self.frame.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    // top line
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];
    [path closePath];
    
    self.layer.shadowPath = path.CGPath;
}

- (void)shadeBottom {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.masksToBounds = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.75;
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shouldRasterize = YES; // 设置缓存
    self.layer.rasterizationScale = [UIScreen mainScreen].scale; // 设置抗锯齿边缘
    
    CGSize size = self.frame.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    // bottom line
    [path moveToPoint:CGPointMake(0, size.height)];
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path closePath];
    
    self.layer.shadowPath = path.CGPath;
}

- (void)shadeAround {
    [self shadeAroundwithColor:[UIColor blackColor] depth:2.0f];
}

- (void)shadeAroundwithColor:(UIColor *)color depth:(CGFloat)depth {
    self.layer.shadowColor = color.CGColor;
    self.layer.masksToBounds = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = depth;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shouldRasterize = YES; // 设置缓存
    self.layer.rasterizationScale = [UIScreen mainScreen].scale; // 设置抗锯齿边缘
    
    //    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath; // UICollectionViewCell 加上这段，有问题
}

@end

typedef NS_ENUM(NSInteger, EdgeType) {
    TopBorder = 10000,
    LeftBorder = 20000,
    BottomBorder = 30000,
    RightBorder = 40000
};

@implementation UIView ( CustomBorder )

- (void)removeTopBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == TopBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)removeLeftBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == LeftBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)removeBottomBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == BottomBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)removeRightBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == RightBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self addTopBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self addLeftBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth {
    [self addBottomBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self addRightBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge {
    [self removeTopBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = TopBorder;
    
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & JKExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & JKExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLenght = self.bounds.size.width - endPoint - startPoint;
        border.frame = CGRectMake(startPoint, 0.0, borderLenght, borderWidth);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}


- (void)addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge {
    [self removeLeftBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = LeftBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & JKExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & JKExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.height - startPoint - endPoint;
        border.frame = CGRectMake(0.0, startPoint, borderWidth, borderLength);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
    
}


- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge {
    [self removeBottomBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = BottomBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & JKExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & JKExcludeEndPoint) {
        endPoint += point;
    }
    
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.width - startPoint - endPoint;
        border.frame = CGRectMake(startPoint, self.bounds.size.height - borderWidth, borderLength, borderWidth);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}

- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge {
    [self removeRightBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = RightBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & JKExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & JKExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.height - startPoint - endPoint;
        border.frame = CGRectMake(self.bounds.size.width - borderWidth, startPoint, borderWidth, borderLength);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}


@end

@implementation UIView ( Recursion )

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView *)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse {
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}

- (void)runBlockOnAllSubviews:(ObjectBlock)block {
    block(self);
    for (UIView* view in [self subviews]) {
        [view runBlockOnAllSubviews:block];
    }
}

- (void)runBlockOnAllSuperviews:(ObjectBlock)block {
    block(self);
    if (self.superview) {
        [self.superview runBlockOnAllSuperviews:block];
    }
}

- (void)enableAllControlsInViewHierarchy {
    [self runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]]) {
            [(UIControl *)view setEnabled:YES];
        } else if ([view isKindOfClass:[UITextView class]]) {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

- (void)disableAllControlsInViewHierarchy {
    [self runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]]) {
            [(UIControl *)view setEnabled:NO];
        } else if ([view isKindOfClass:[UITextView class]]) {
            [(UITextView *)view setEditable:NO];
        }
    }];
}
@end

@implementation UIView ( Screenshot )
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage *)takeSnapshot {
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)screenshot:(CGFloat)maxWidth {
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
    }
    
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //end
    self.transform = oldTransform;
    
    return screenshot;
}
@end


@interface UIView ()

@property (nonatomic, assign) BOOL ignoreSingleTapEvent;
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

@property (nonatomic, strong) NSString *singleTapActionHandlerSelector;
@property (nonatomic, strong, readonly) NSString *singleTapSwizzleActionHandlerSelector;

@end

@implementation UIView (Action)

#pragma mark -

- (void)addTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    recog.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:recog];
}

- (void)addTapGestureWithTarget:(id)target action:(SEL)action acceptEventInterval:(NSTimeInterval)interval {
    // 第一个参数：给哪个类添加方法
    // 第二个参数：添加方法的方法编号
    // 第三个参数：添加方法的函数实现（函数地址）
    // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
    class_addMethod(((NSObject *)target).class, NSSelectorFromString(self.singleTapSwizzleActionHandlerSelector), (IMP)onSingleTap, "v@:@");
    
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(self.singleTapSwizzleActionHandlerSelector)];
    recog.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:recog];
    
    // Back up real selector
    self.singleTapActionHandlerSelector = NSStringFromSelector(action);
}

- (void)addDoubleTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    recog.numberOfTapsRequired = 2;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:recog];
}

- (void)addPanGestureWithTarget:(id)target action:(SEL)action {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:pan];
}

- (void)addLongPressGestureWithTarget:(id)target action:(SEL)action {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:longPress];
}

#pragma mark -

void onSingleTap(id self, SEL sel, UITapGestureRecognizer *recognizer) {
    UIView *view = recognizer.view;
    
    if (view.ignoreSingleTapEvent) {
        LOG(@"ignoreSingleTapEvent triggered!");
        
        return;
    }
    
    view.ignoreSingleTapEvent = YES;
    [view performSelector:@selector(setIgnoreSingleTapEvent:) withObject:@(NO) afterDelay:1.f];
    
    [self performSelector:NSSelectorFromString(view.singleTapActionHandlerSelector) withObject:recognizer];
}

#pragma mark -

- (BOOL)ignoreSingleTapEvent {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIgnoreSingleTapEvent:(BOOL)ignoreSingleTapEvent {
    objc_setAssociatedObject(self, @selector(ignoreSingleTapEvent), @(ignoreSingleTapEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, @selector(acceptEventInterval), @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)singleTapSwizzleActionHandlerSelector {
    return @"onSingleTapActionHandler:";
}

- (NSString *)singleTapActionHandlerSelector {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSingleTapActionHandlerSelector:(NSString *)singleTapActionHandlerSelector {
    objc_setAssociatedObject(self, @selector(singleTapActionHandlerSelector), singleTapActionHandlerSelector, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)addTapActionWithBlock:(UIGestureActionBlock)block {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, @selector(addTapActionWithBlock:));
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, @selector(addTapActionWithBlock:), gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, @selector(handleActionForTapGesture:), block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        UIGestureActionBlock block = objc_getAssociatedObject(self, @selector(handleActionForTapGesture:));
        if (block) {
            block(gesture);
        }
    }
}

- (void)addLongPressActionWithBlock:(UIGestureActionBlock)block {
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, @selector(addLongPressActionWithBlock:));
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, @selector(addLongPressActionWithBlock:), gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, @selector(handleActionForLongPressGesture:), block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        UIGestureActionBlock block = objc_getAssociatedObject(self, @selector(handleActionForLongPressGesture:));
        
        if (block) {
            block(gesture);
        }
    }
}

@end
