#import "UIResponder+Extension.h"

@implementation UIResponder ( Chain )

- (NSString *)responderChainDescription {
    NSMutableArray *responderChainStrings = [NSMutableArray array];
    [responderChainStrings addObject:[self class]];
    UIResponder *nextResponder = self;
    while ((nextResponder = [nextResponder nextResponder])) {
        [responderChainStrings addObject:[nextResponder class]];
    }
    __block NSString *returnString = @"Responder Chain:\n";
    __block int tabCount = 0;
    [responderChainStrings enumerateObjectsWithOptions:NSEnumerationReverse
                                            usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                if (tabCount) {
                                                    returnString = [returnString stringByAppendingString:@"|"];
                                                    for (int i = 0; i < tabCount; i++) {
                                                        returnString = [returnString stringByAppendingString:@"----"];
                                                    }
                                                    returnString = [returnString stringByAppendingString:@" "];
                                                }
                                                else {
                                                    returnString = [returnString stringByAppendingString:@"| "];
                                                }
                                                returnString = [returnString stringByAppendingFormat:@"%@ (%@)\n", obj, @(idx)];
                                                tabCount++;
                                            }];
    return returnString;
}

@end

// MARK: - 

static __weak id __currentFirstResponder;

@implementation UIResponder ( FirstResponder )

+ (id)currentFirstResponder {
    __currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return __currentFirstResponder;
}

- (void)findCurrentFirstResponder:(id)sender {
    __currentFirstResponder = self;
}

@end
