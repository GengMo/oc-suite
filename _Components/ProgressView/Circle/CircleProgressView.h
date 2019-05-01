//
//  ZXYCircleProgress.h
//  ZXYProgressView
//
//  Created by Mars on 2017/11/28.
//  Copyright © 2017年 赵向禹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYCircleProgress : UIView

/** 进度 */
@property (nonatomic, assign) CGFloat progress;
/** 底层颜色 */
@property (nonatomic, strong) UIColor *bottomColor;
/** 顶层颜色 */
@property (nonatomic, strong) UIColor *topColor;
/** 宽度 */
@property (nonatomic, assign) CGFloat progressWidth;

/** 原点 */
@property (nonatomic, assign) CGPoint origin;
/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 起始 */
@property (nonatomic, assign) CGFloat startAngle;
/** 结束 */
@property (nonatomic, assign) CGFloat endAngle;

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress;

@end
