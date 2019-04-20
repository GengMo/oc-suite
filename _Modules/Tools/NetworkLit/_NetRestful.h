#import "_NetHost.h"
#import "_NetRequest.h"

// MARK: -

typedef NSDictionary * (^ _NetHeaderAppendBlock)(NSString *apiname);
typedef NSDictionary * (^ _NetParameterAppendBlock)(NSString *apiname);
typedef NSError * (^ _NetResponseFilterBlock)(NSDictionary *response);
typedef void * (^ _NetShowHudBlock)(void);
typedef void * (^ _NetDismissHudBlock)(void);

// MARK: -

@interface _NetRestful : NSObject

// MARK: -

- (instancetype) init __attribute__((unavailable("init not available, call initWithHostname instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call initWithHostname instead")));

- (instancetype)initWithHostname:(NSString *)hostname paramEncoding:(NetRequestParameterEncoding)encoding secure:(BOOL)isSecure;

@property (nonatomic, strong) _NetHeaderAppendBlock headerAppendHandler;
@property (nonatomic, strong) _NetParameterAppendBlock parameterAppendHandler;
@property (nonatomic, strong) _NetResponseFilterBlock responseFilterHandler;
@property (nonatomic, strong) _NetShowHudBlock showHudHandler;
@property (nonatomic, strong) _NetDismissHudBlock dismissHudHandler;

// MARK: - Restful api

- (void)GET:(NSString *)path
      param:(NSDictionary *)param
    success:(void (^)(id data))successHandler
    failure:(void (^)(NSError *error))failureHandler;

- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
     success:(void (^)(id data))successHandler
     failure:(void (^)(NSError *error))failureHandler;

- (NSDictionary *)defaultHeader;

//- (NSDictionary *)appendParametersOnApi:(NSString *)api;
//- (NSError *)checkResponseIfHaveError:(NSDictionary *)response;
//- (NSDictionary *)filteredResponse:(NSDictionary *)originResponse;

@end
