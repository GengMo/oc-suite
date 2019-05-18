
#import <_Foundation/_Foundation.h>
#import "MapComponentConfig.h"
#import "LocationViewController.h"
#import "LocationIndicatorVC.h"
#import "AddressInputHintViewController.h"

@class MapComponentConfig;

@interface MapComponent : NSObject

@singleton( MapComponent )

@prop_instance( MapComponentConfig, config)

@end
