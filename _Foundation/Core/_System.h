//
//  _System.h
//  _Foundation
//
//  Created by fallen.ink on 2019/4/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PermissionTypeBluetoothLE,
    PermissionTypeCalendar,
    PermissionTypeContacts,
    PermissionTypeLocation,
    PermissionTypeMicrophone,
    PermissionTypeMotion,
    PermissionTypePhotos,
    PermissionTypeReminders,
} PermissionType;

typedef enum {
    PermissionAccessDenied, //User has rejected feature
    PermissionAccessGranted, //User has accepted feature
    PermissionAccessRestricted, //Blocked by parental controls or system settings
    PermissionAccessUnknown, //Cannot be determined
    PermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    PermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} PermissionAccess;

@interface _System : NSObject

//Check permission of service. Cannot check microphone or motion without asking user for permission
- (PermissionAccess)hasAccessToBluetoothLE;
- (PermissionAccess)hasAccessToCalendar;
- (PermissionAccess)hasAccessToContacts;
- (PermissionAccess)hasAccessToLocation;
- (PermissionAccess)hasAccessToPhotos;
- (PermissionAccess)hasAccessToReminders;

//Request permission with callback
- (void)requestAccessToCalendarWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)requestAccessToContactsWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)requestAccessToMicrophoneWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)requestAccessToPhotosWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)requestAccessToRemindersWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)requestAccessToLocationWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;

//No failure callback available
- (void)requestAccessToMotionWithSuccess:(void(^)(void))accessGranted;

//Needs investigating - unsure whether it can be implemented because of required delegate callbacks
//-(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted;

@property (nonatomic, readonly) CGRect keyboardFrame;

@end

#define shared_system [_System sharedInstance]

NS_ASSUME_NONNULL_END
