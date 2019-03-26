
#import <_Foundation/_Foundation.h>
#import "MapConfig.h"
#import "LocationViewController.h"
#import "LocationIndicatorVC.h"
#import "AddressInputHintViewController.h"

@class MapConfig;

@interface MapService : NSObject

@singleton( MapService )

@prop_instance( MapConfig, config)

- (void)initGDAPIKey;

@end
