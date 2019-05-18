//
//  ComponentMap.m
//  component
//
//  Created by fallen.ink on 3/16/16.
//  Copyright © 2016 OpenTeam. All rights reserved.
//

#import "MapComponent.h"
#import "MapComponentConfig.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@implementation MapComponent

@def_singleton( MapComponent )

@def_prop_instance(MapComponentConfig, config)

@end
