//
//  TimeService.m
//  consumer
//
//  Created by fallen on 16/8/23.
//
//

#import "TimeService.h"

@implementation TimeService

@def_singleton( TimeService )

@def_prop_assign( NSTimeInterval, timeOffset )
@def_prop_instance( TimePresenter, presenter )

@end

@def_namespace( service , time, TimeService )