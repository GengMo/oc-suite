#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

// Usage see: [UITableView rotateToHorizontalScrollable]
- (void)rotateToHorizontalScrollable;

/**
 *  Forbid user selection
 */
- (void)disableSelection;

/**
 *  Allow user selection
 */
- (void)enableSelection;

@end
