#import <libkern/OSAtomic.h>
#import "BaseViewModel.h"
#import "BaseDataSource.h"

@interface BaseViewModel ()

// Improves the performance of KVO on the receiver.
//
// See the documentation for <NSKeyValueObserving> for more information.
@property (atomic) void *observationInfo;

@end

@implementation BaseViewModel

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
    }
    
    return self;
}

// MARK: - 数据源

- (int32_t)numberOfSections {
    return 0;
}

- (int32_t)numberOfRowsInSection:(int32_t)section {
    return 0;
}

- (id)modelForRowAtSection:(int32_t)section row:(int32_t)row {
    return nil;
}


// MARK: - Properties

// We create many, many view models, so these properties need to be as lazy and
// memory-conscious as possible.
//@synthesize didBecomeActiveSignal = _didBecomeActiveSignal;
//@synthesize didBecomeInactiveSignal = _didBecomeInactiveSignal;

//- (void)setActive:(BOOL)active {
//    // Skip KVO notifications when the property hasn't actually changed. This is
//    // especially important because self.active can have very expensive
//    // observers attached.
//    if (active == _active) return;
//
//    [self willChangeValueForKey:@keypath(self.active)];
//    _active = active;
//    [self didChangeValueForKey:@keypath(self.active)];
//}

//- (RACSignal *)didBecomeActiveSignal {
//    if (_didBecomeActiveSignal == nil) {
//        @weakify(self);
//
//        _didBecomeActiveSignal = [[[RACObserve(self, active)
//            filter:^(NSNumber *active) {
//                return active.boolValue;
//            }]
//            map:^(id _) {
//                @strongify(self);
//                return self;
//            }]
//            setNameWithFormat:@"%@ -didBecomeActiveSignal", self];
//    }
//
//    return _didBecomeActiveSignal;
//}

//- (RACSignal *)didBecomeInactiveSignal {
//    if (_didBecomeInactiveSignal == nil) {
//        @weakify(self);
//
//        _didBecomeInactiveSignal = [[[RACObserve(self, active)
//            filter:^ BOOL (NSNumber *active) {
//                return !active.boolValue;
//            }]
//            map:^(id _) {
//                @strongify(self);
//                return self;
//            }]
//            setNameWithFormat:@"%@ -didBecomeInactiveSignal", self];
//    }
//
//    return _didBecomeInactiveSignal;
//}

// MARK: - NSKeyValueObserving

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    // We'll generate notifications for this property manually.
    if ([key isEqual:@keypath(BaseViewModel.new, active)]) {
        return NO;
    }

    return [super automaticallyNotifiesObserversForKey:key];
}


@end

// MARK: -

@implementation UIViewController ( ViewModel )

- (void)bind {
    
}

@end
