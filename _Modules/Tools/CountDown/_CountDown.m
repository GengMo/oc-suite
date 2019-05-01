
#import "_CountDown.h"

@interface _CountDown ()

@property (nonatomic, strong) dispatch_source_t timer;
@prop_strong( dispatch_block_t, timerHandler )

@property (nonatomic, strong) void (^ currentBlock)(NSTimeInterval);
@property (nonatomic, strong) void (^ completionBlock)(void);

@end

@implementation _CountDown

@def_prop_readonly( NSTimeInterval, leftTime )
@def_prop_readonly( BOOL, paused )

@def_prop_strong( dispatch_block_t, timerHandler )

// ----------------------------------
// MARK: - Public methods
// ----------------------------------

- (instancetype)initWithInterval:(NSTimeInterval)timeLeft {
    self = [super init];
    if (self) {
        _leftTime = timeLeft;
    }
    return self;
}

- (void)setLeftTime:(NSTimeInterval)leftTime {
    [self stop];
    
    _leftTime = leftTime;
}

- (void)start:(void (^)(NSTimeInterval))currentBlock {
    self.currentBlock = currentBlock;
    [self stop];
    
    [self startCountDownTimer];
}

- (void)start:(void (^)(NSTimeInterval))currentBlock completion:(void (^)(void))completion {
    self.currentBlock = currentBlock;
    self.completionBlock = completion;
    
    [self stop];
    
    _paused = NO;
    [self startCountDownTimer];
}

- (void)pause {
    if (!_paused) {
        _paused = YES;
        
        dispatch_suspend(self.timer);
    }
}

- (void)resume {
    if (_paused) {
        _paused = NO;
        
        dispatch_resume(self.timer);
    }
}

- (void)stop {
    if (self.timer) {
        if (!dispatch_source_testcancel(self.timer)) {
            dispatch_source_set_cancel_handler(self.timer, self.timerHandler);
            //尚未取消，先关闭定时器
            dispatch_source_cancel(self.timer);
        }
        self.timer = nil;
    }
}

- (void)dealloc {
    self.currentBlock = nil;
    self.completionBlock = nil;
}

// ----------------------------------
// MARK: - Private methods
// ----------------------------------

- (void)startCountDownTimer {
    __block NSTimeInterval time = self.leftTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
//    Dispatch Source一共可以监听六类事件，分为11个类型：
//    DISPATCH_SOURCE_TYPE_DATA_ADD：属于自定义事件，
//    可以通过dispatch_source_get_data函数获取事件变量数据，在我们自定义的方法中可以调用dispatch_source_merge_data函数向Dispatch Source设置数据。
//    DISPATCH_SOURCE_TYPE_DATA_OR：属于自定义事件，用法同上面的类型一样。
//    DISPATCH_SOURCE_TYPE_MACH_SEND：Mach端口发送事件。
//    DISPATCH_SOURCE_TYPE_MACH_RECV：Mach端口接收事件。
//    DISPATCH_SOURCE_TYPE_PROC：与进程相关的事件。
//    DISPATCH_SOURCE_TYPE_READ：读文件事件。
//    DISPATCH_SOURCE_TYPE_WRITE：写文件事件。
//    DISPATCH_SOURCE_TYPE_VNODE：文件属性更改事件。
//    DISPATCH_SOURCE_TYPE_SIGNAL：接收信号事件。
//    DISPATCH_SOURCE_TYPE_TIMER：定时器事件。
//    DISPATCH_SOURCE_TYPE_MEMORYPRESSURE：内存压力事件。
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    @weakify(self)
    self.timerHandler = ^{
        @strongify(self)
        
        time --;
        if (time <= 0) {
            [self stop];
            
            if (self.completionBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    invoke_nullable_block_noarg(self.completionBlock)
                    self.completionBlock = nil;
                });
                self.currentBlock = nil;
            }
        }
        
        self->_leftTime = time;
        if (self.currentBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.currentBlock(time);
            });
        }
    };
    dispatch_source_set_event_handler(self.timer, self.timerHandler);
    dispatch_resume(self.timer);
}


@end
