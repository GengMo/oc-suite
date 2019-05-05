#import <_Foundation/_Foundation.h>
#import "ShareParamBuilder.h"
#import "BaseViewController.h"

#pragma mark -
 
@class ShareActivityVC;

@interface ShareActivityVC : BaseViewController

@property (nonatomic, strong) NSString *eventCode;

@singleton( ShareActivityVC )

/**
 *  用ShareParamBuilder初始化
 */
- (void)shareWithWithParamBuilder:(ShareParamBuilder *)paramBuilder
                   shareViewTitle:(NSString *)title;
- (void)dismissSharePopup;

@end
