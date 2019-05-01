/**
 * Usage 1
 
 _customView = [[WaveProcessView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, 70, self.view.frame.size.width * 0.8, self.view.frame.size.width * 0.8) animated:YES];
 _customView.percent = 0.6;
 _customView.showBgLineView = NO;
 _customView.waveLength = self.view.frame.size.width/2;
 _customView.amplitude = self.view.frame.size.width * 0.8 / 20;
 _customView.showBgLineView = NO;
 _customView.scaleCount = 0;
 _customView.waterBgColor = [UIColor colorWithRed:0.718 green:0.890 blue:0.988 alpha:1.00];
 _customView.backWaterColor = [UIColor clearColor];
 _customView.lineBgColor = [UIColor clearColor];
 _customView.scaleColor = [UIColor clearColor];
 _customView.label = @"老湿的酒量";
 
 */

#import <UIKit/UIKit.h>

@interface WaveProcessView : UIView

+ (id)createForZhangHengWithFrame:(CGRect)frame
                          percent:(CGFloat)percent
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                  foregroundColor:(UIColor *)foregroundColor
                  backgroundColor:(UIColor *)backgroundColor;

- (id)initWithFrame:(CGRect)frame animated:(BOOL)animated;

/**
 *  比例尺长度
 */
@property (nonatomic, assign) CGFloat scaleDivisionsLength;
/**
 *  比例次刻度宽度
 */
@property (nonatomic, assign) CGFloat scaleDivisionsWidth;
/**
 *  比例次到self边距
 */
@property (nonatomic, assign) CGFloat scaleMargin;
/**
 *  比例尺的个数
 */
@property (nonatomic, assign) CGFloat scaleCount;
/**
 *  比例尺到圆形波纹的距离
 */
@property (nonatomic, assign) CGFloat waveMargin;
/**
 *  波长
 */
@property (nonatomic, assign) CGFloat waveLength;

/**
 * 振幅
 */
@property (nonatomic, assign) CGFloat amplitude;
/**
 *  百分比
 */
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, assign) BOOL showPercent;
/**
 *  百分比描述
 */
@property (nonatomic, strong) NSString *label;
/**
 *  前波浪颜色
 */
@property (nonatomic, readwrite, strong) UIColor *frontWaterColor;
/**
 *  后波浪颜色
 */
@property (nonatomic, readwrite, strong) UIColor *backWaterColor;
/**
 *  波浪的背景颜色
 */
@property (nonatomic, readwrite, strong) UIColor *waterBgColor;
/**
 *  刻度线背景色
 */
@property (nonatomic, strong) UIColor *lineBgColor;
/**
 *  刻度线颜色
 */
@property (nonatomic, strong) UIColor *scaleColor;
/**
 *  是否显示背景上的线条
 */
@property (nonatomic, assign) BOOL showBgLineView;

@end
