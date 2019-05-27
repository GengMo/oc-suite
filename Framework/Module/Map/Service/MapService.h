
#import <Framework/_Foundation.h>
#import "MapConfig.h"

@interface MapService : NSObject

@singleton( MapService )

@prop_instance( MapConfig, config)

- (void)initGDAPIKey;

@end
