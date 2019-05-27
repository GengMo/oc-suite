
#import <Framework/_Foundation.h>
#import "MapComponentConfig.h"
#import "LocationViewController.h"
#import "LocationIndicatorVC.h"
#import "AddressInputHintViewController.h"

@class ComponentMapConfig;

@interface LoginComponent : NSObject

@singleton( LoginComponent )

@prop_instance( ComponentMapConfig, config)

- (void)initGDAPIKey;

@end
