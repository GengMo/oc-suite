#import "_Macros.h"
#import "_Singleton.h"
#import "_Property.h"

#pragma mark -

// 更新时间：2017/10/18
// http://www.jianshu.com/p/b23016bb97af
// 更新时间：2019/04/29
// https://www.jianshu.com/p/f2d83ddb09fe
typedef enum : NSUInteger {
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    
    IPHONE_4,
    IPHONE_4S,
    
    IPHONE_5,
    IPHONE_5C,
    IPHONE_5S,
    
    IPHONE_6,
    IPHONE_6_PLUS,
    IPHONE_6S,
    IPHONE_6S_PLUS,
    
    IPHONE_7,
    IPHONE_7_PLUS,
    
    IPHONE_8,
    IPHONE_8_PLUS,
    
    IPHONE_X,
    IPHONE_XS,
    IPHONE_XR,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_3,
    IPAD_4,
    
    IPAD_MINI,
    IPAD_MINI_RETINA,
    IPAD_MINI_3,
    IPAD_AIR,
    IPAD_AIR_2,
    
    IPAD_PRO_9,
    IPAD_PRO_12,
    
    SIMULATOR
} HardwareType;

typedef enum : NSUInteger {
    /* The passcode status was unknown */
    PasscodeStatusUnknown   = 0,
    /* The passcode is enabled */
    PasscodeStatusEnabled   = 1,
    /* The passcode is disabled */
    PasscodeStatusDisabled  = 2
} PasscodeStatus;

#pragma mark - 

// 即将废弃，用表达式，不再枚举！！
extern BOOL IOS8; // 准确的iOS8， 非iOS7，非iOS9
extern BOOL IOS9;
extern BOOL IOS10;
extern BOOL IOS11;

extern BOOL IOS11_OR_LATER;
extern BOOL IOS10_OR_LATER;
extern BOOL IOS9_OR_LATER;
extern BOOL IOS8_OR_LATER;
extern BOOL IOS7_OR_LATER;
extern BOOL IOS6_OR_LATER;
extern BOOL IOS5_OR_LATER;
extern BOOL IOS4_OR_LATER;
extern BOOL IOS3_OR_LATER;

extern BOOL IOS11_OR_EARLIER;
extern BOOL IOS9_OR_EARLIER;
extern BOOL IOS8_OR_EARLIER;
extern BOOL IOS7_OR_EARLIER;
extern BOOL IOS6_OR_EARLIER;
extern BOOL IOS5_OR_EARLIER;
extern BOOL IOS4_OR_EARLIER;
extern BOOL IOS3_OR_EARLIER;

extern BOOL IS_SCREEN_4_INCH;
extern BOOL IS_SCREEN_35_INCH;
extern BOOL IS_SCREEN_47_INCH; // , design area: 750x1334 @2x
extern BOOL IS_SCREEN_55_INCH;
extern BOOL IS_SCREEN_58_INCH; // 458 ppi, Safe design area: 750x1468 @2x

// Device model
// 参考：http://www.jianshu.com/p/b23016bb97af
// 即将废弃！
extern BOOL IS_IPHONE_4;
extern BOOL IS_IPHONE_4S;
extern BOOL IS_IPHONE_5;
extern BOOL IS_IPHONE_5C;
extern BOOL IS_IPHONE_5S;
extern BOOL IS_IPHONE_6;
extern BOOL IS_IPHONE_6S;
extern BOOL IS_IPHONE_6P;
extern BOOL IS_IPHONE_6SP;
extern BOOL IS_IPHONE_6SE;
extern BOOL IS_IPHONE_7;
extern BOOL IS_IPHONE_7P;
extern BOOL IS_IPHONE_8;
extern BOOL IS_IPHONE_8P;
extern BOOL IS_IPHONE_X;
extern BOOL IS_SIMULATOR;

// Device design model
extern BOOL IS_IPHONE_DESIGN_X;
#define IS_NOT_IPHONE_DESIGN_X  !IS_IPHONE_DESIGN_X

#pragma mark -

#define sharedDevice [_Device sharedInstance]

@interface _Device : NSObject

@singleton( _Device )

@prop_readonly( NSString *,         now );

@prop_readonly( NSString *,			osVersion );
//@prop_readonly( OperationSystem,    osType );
@prop_readonly( NSString *,			bundleVersion );
@prop_readonly( NSString *,			bundleShortVersion );
@prop_readonly( NSInteger,          bundleBuild );
@prop_readonly( NSString *,			bundleIdentifier );
@prop_readonly( NSString *,			urlSchema );
@prop_readonly( NSString *,			deviceModel );

@prop_readonly( CGSize,				screenSize );

@prop_readonly( double,             totalMemory );              // 获取设备物理内存(单位：MB)
@prop_readonly( double,				availableMemory );          // 获取当前设备可用内存(单位：MB）
@prop_readonly( double,				usedMemory );               // 获取当前任务所占用的内存（单位：MB）

@prop_readonly( double,				availableDisk );            // 获取当前设备可用磁盘空间(单位：MB）

@prop_readonly( NSString *,         appSize );

@prop_readonly( NSString *,         buildCode ); // build 号
@prop_readonly( int32_t,            intAppVersion );
@prop_readonly( NSString *,         appVersion );

// accessory
@prop_readonly( BOOL,               photoCaptureAccessable ); // 拍照权限是否打开
@prop_readonly( BOOL,               photoLibraryAccessable ); // 相册权限是否打开

/**
 *  en_US, zh_CN,
 */
@prop_readonly( NSArray *,          languages ) // 系统语言
@prop_readonly( NSString *,         currentLanguage ) // 系统当前使用语言

// uuid inspired by FCUUID
@prop_readonly( NSString *,         uuid ); // changes each time (no persistent)
@prop_readonly( NSString *,         uuidForSession ) // changes each time the app gets launched (persistent to session)
@prop_readonly( NSString *,         uuidForInstallation ) // changes each time the app gets installed (persistent to installation)
@prop_readonly( NSString *,         uuidForVendor ) // changes each time all the apps of the same vendor are uninstalled (this works exactly as identifierForVendor)
@prop_readonly( NSString *,         uuidForDevice ) // changes only on system reset, this is the best replacement to the good old udid (persistent to device)

@prop_readonly( NSString *,         deviceInfo )
@prop_readonly( NSString *,         deviceVersion )

@prop_readonly( HardwareType,       hardware )
@prop_readonly( NSString *,         hardwareAsString )
@prop_readonly( NSString *,         hardwareDescription )

@prop_readonly( NSString *,         systemName )
@prop_readonly( CGFloat,            batteryLevel )
@prop_readonly( NSString *,         macAddress )
@prop_readonly( NSUInteger,         cpuFrequency )              // CPU 主频
@prop_readonly( NSUInteger,         busFrequency )              // BUS 主频
@prop_readonly( NSUInteger,         ramSize )              // 内存大小
@prop_readonly( NSUInteger,         cpuNumber )     // the current device CPU number
@prop_readonly( NSString *,         systemVersion )          // iOS系统的版本号
@prop_readonly( BOOL,               hasCamera )                 // 当前系统是否有摄像头
@prop_readonly( NSUInteger,         totalMemoryBytes )          // 手机内存总量, 返回的是字节数
@prop_readonly( NSUInteger,         freeMemoryBytes )          // 手机可用内存, 返回的是字节数
@prop_readonly( long long,          freeDiskSpaceBytes )          // 手机硬盘空闲空间, 返回的是字节数
@prop_readonly( long long,          totalDiskSpaceBytes )          // 手机硬盘总空间, 返回的是字节数

@prop_readonly( BOOL,               passcodeStatusSupported ) // Determines if the device supports the `passcodeStatus` check. Passcode check is only supported on iOS 8.
@prop_readonly( PasscodeStatus,     passcodeStatus ) // Checks and returns the devices current passcode status. If `passcodeStatusSupported` returns NO then `LNPasscodeStatusUnknown` will be returned.

- (NSString *)urlSchemaWithName:(NSString *)name;

- (BOOL)isOsVersionOrEarlier:(NSString *)ver;
- (BOOL)isOsVersionOrLater:(NSString *)ver;
- (BOOL)isOsVersionEqualTo:(NSString *)ver;

- (BOOL)isScreenSizeSmallerThan:(CGSize)size;
- (BOOL)isScreenSizeBiggerThan:(CGSize)size;
- (BOOL)isScreenSizeEqualTo:(CGSize)size;

// 临时写在这里
@prop_readonly( NSString *,            deviceUDID ); // Stored in keychain

/**
 *  Setting page
 */
- (void)openSettings;

/**
 *  打电话
 *
 *  @param phone 电话号码
 */
- (BOOL)call:(NSString *)phone;

@end

#define shared_device [_Device sharedInstance]
