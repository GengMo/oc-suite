#import "_Service.h"

@interface WechatLoginService : _Service

@singleton( WechatLoginService )

/**
 *  @desc 最近一次错误的实际原因（子类中）
 
 *  @error 而handler中传的错误是通用错误（ComponentPayment中声明）
 */
@property (nonatomic, assign) NSUInteger    errorCode; // 调试版本使用
@property (nonatomic, copy)   NSString *    errorDesc; // 调试版本使用

@property (nonatomic, copy) ObjectBlock     waitingHandler;
@property (nonatomic, copy) ObjectBlock     succeedHandler;
@property (nonatomic, copy) ErrorBlock      failedHandler; // 支付错误、支付取消

/**
 *  支付成功，不区分qqing支付、第三方支付
 */
@error( err_Succeed )
/**
 *  支付失败，不区分qqing支付、第三方支付
 */
@error( err_Failure )
/**
 *  第三方支付取消
 */
@error( err_Cancel )
/**
 *  指定的第三方支付没有安装
 */
@error( err_Uninstalled )

/**
 *  NSNumber
 */
@notification( WAITTING )

/**
 *  携带必要的应答对象
 */
@notification( SUCCEED )

/**
 *  携带错误对象
 
 *  NSError
 */
@notification( FAILED )

@end
