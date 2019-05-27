//
//  BaseNavigationBar.h
//  consumer
//
//  Created by fallen.ink on 9/5/16.
//
#import <UIKit/UIKit.h>
#import <Framework/_Foundation.h>

@interface BaseNavigationBar : UINavigationBar

@prop_class( CGFloat,       preferredBarAlpha )             // [0.70f] 设置
@prop_class( UIColor *,     preferredBarTintColor )         // [nil] 设置背景颜色
@prop_class( UIColor *,     preferredTintColor )            // [nil] 设置主题颜色
@prop_class( UIColor *,     preferredForegroundColor )      // [white] 设置字体颜色
@prop_class( UIFont *,      preferredForegroundFont )       // [bold, 20] 设置字体

/**
 * If set to YES, this will override the opacity of the barTintColor and will set it to
 * the value contained in preferredBarAlpha.
 */
@prop_assign( BOOL,         overrideOpacity )
/**
 * Determines whether or not the extra color layer should be displayed.
 * @param display a BOOL; YES for keeping it visible, NO to hide it.
 * @warning this method is not available in the actual implementation, and is only here for demonstration purposes.
 */
@prop_assign( BOOL,         displayColorLayer )

@end
