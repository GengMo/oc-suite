//
//  UIImage+PPRoundedAvatar.m
//  Demo
//
//  Created by Vernon on 2017/3/23.
//  Copyright © 2017年 Vernon. All rights reserved.
//

#import "UIImage+PPRoundedAvatar.h"

@implementation UIImage (PPRoundedAvatar)

- (UIImage *)pp_imageByRoundCornerRadius:(CGFloat)radius
                               scaleSize:(CGSize)newSize
{
    if (radius > 0 && newSize.width > 0 && newSize.height > 0) {
        return [self pp_imageByRoundCornerRadius:radius scaleSize:newSize borderWidth:0 borderColor:nil];
    }
    return self;
}

- (UIImage *)pp_imageByRoundCornerRadius:(CGFloat)radius
                                scaleSize:(CGSize)newSize
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
{
    if (radius > 0 && newSize.width > 0 && newSize.height > 0) {
        UIImage *scaledImage = [self pp_imageScaledAspectToFillSize:newSize];
        return [scaledImage pp_imageByRoundCornerRadius:radius
                                                 corners:UIRectCornerAllCorners
                                             borderWidth:borderWidth
                                             borderColor:borderColor];
    }
    return self;
}

- (UIImage *)pp_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
{
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image pp_imageByRoundBorderedColor:borderColor borderWidth:borderWidth];
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)pp_imageByRoundBorderedColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth
{
    if (self.size.height != self.size.width) {
        return self;
    }
    
    if (!borderColor || borderWidth > self.size.width / 2 || borderWidth < 0) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [self drawAtPoint:CGPointZero];
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGFloat strokeInset = borderWidth / 2;
    CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
    CGFloat radius = self.size.width / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, borderWidth)];
    path.lineWidth = borderWidth;
    [borderColor setStroke];
    [path stroke];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)pp_roundImageWithColor:(UIColor *)color radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *roundedColorImage = [colorImage pp_imageByRoundCornerRadius:radius scaleSize:CGSizeMake(2 * radius, 2 * radius)];
    return roundedColorImage;
}

- (UIImage *)pp_imageScaledAspectToFillSize:(CGSize)targerSize
{
    CGFloat widthRatio = targerSize.width  / self.size.width;
    CGFloat heightRatio = targerSize.height / self.size.height;
    CGFloat scalingFactor = fmax(widthRatio, heightRatio);
    CGSize newSize = CGSizeMake(self.size.width  * scalingFactor, self.size.height * scalingFactor);
    UIGraphicsBeginImageContextWithOptions(targerSize, NO, 0);
    [self drawInRect:CGRectMake((targerSize.width  - newSize.width)  / 2, (targerSize.height - newSize.height) / 2, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
