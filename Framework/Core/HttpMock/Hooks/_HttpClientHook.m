#import "_HttpClientHook.h"

@implementation _HttpClientHook

- (void)load {
    [NSException raise:NSInternalInconsistencyException
                format:@"Method '%@' not implemented. Subclass '%@' and override it", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (void)unload {
    [NSException raise:NSInternalInconsistencyException
                format:@"Method '%@' not implemented. Subclass '%@' and override it", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

@end
