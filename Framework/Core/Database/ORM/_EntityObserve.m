#import "_DBCore.h"
#import "_EntityObserve.h"

@implementation _Entity ( Observe )

+ (BOOL)observeWithName:(NSString * const)name block:(DatabaseDealStateBlock)block {
    NSString* uniqueName = [NSString stringWithFormat:@"%@*%@",NSStringFromClass([self class]),name];
    return [[_Database sharedInstance] observeWithName:uniqueName block:block];
}

+ (BOOL)unobserveWithName:(NSString * const)name {
    NSString* uniqueName = [NSString stringWithFormat:@"%@*%@",NSStringFromClass([self class]),name];
    return [[_Database sharedInstance] unobserveWithName:uniqueName];
}

@end
