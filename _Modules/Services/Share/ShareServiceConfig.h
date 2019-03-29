#import <foundation/foundation.h>

@interface ShareServiceConfig : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *appId;

// URL scheme 方便app之间互相调用
@property (nonatomic, strong) NSString *scheme;

// Client to set
@property (nonatomic, assign) BOOL supported;

@end
