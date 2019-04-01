#import "_Protocol.h"
#import "_SNSTypes.h"

@protocol _ShareParamProtocol <_Protocol>

// 分享平台 & 场景

@property (nonatomic, assign) _SharePlatformType type;

// 分享场景

@property (nonatomic, strong) NSString *platform;
@property (nonatomic, assign) NSUInteger scene; // FIXME: NSString -> NSUInteger

// 分享参数

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSObject *thumb; // url of thumb image / just image
@property (nonatomic, strong) NSString *url; // url of html

@end
