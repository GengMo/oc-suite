#import <Framework/_Foundation.h>
#import "UISearchBar+Extension.h"

@implementation UISearchBar (Extension)

- (UITextField *)textField {
    Class uisearchbartextfield = classof(UISearchBarTextField);
    
    UIView *v = self.subviews.firstObject;
    for (UITextField *s in v.subviews)
        if ([s isKindOfClass:uisearchbartextfield])
            return s;
    
    return nil;
}

@end
