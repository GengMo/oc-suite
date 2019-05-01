//
//  CircleProgressViewController.m
//  startup
//
//  Created by fallen.ink on 2019/5/1.
//  Copyright © 2019 7. All rights reserved.
//

#import <_Components/CircleProgressView.h>
#import <_Components/CircleProgress.h>
#import <_Modules/_Chronograph.h>
#import <_Modules/_CountDown.h>
#import "CircleProgressViewController.h"
#import "AppDelegate.h"

@interface CircleProgressViewController ()

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) CircleProgressView *circle;
//@property (nonatomic, strong) CircleProgress *circle;

//@property (nonatomic, strong) _Chronograph *timer;
@property (nonatomic, strong) _CountDown *timer;

@end

@implementation CircleProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        self.progress = 0.f;

        self.circle = [[CircleProgressView alloc] initWithFrame:CGRectMake(100, 150, 80, 80) progress:0.5];
        self.circle.progressWidth = 4.f;
        self.circle.bottomColor = color_red;
        self.circle.topColor = color_blue;
        [self.view addSubview:self.circle];
    }
    
//    {
//        self.circle = [[CircleProgress alloc]initWithFrame:CGRectMake(100, 300, 80, 80)];
//        self.circle.lineWidth = 6;
//        [self.circle setTitle:@"跳过" forState:UIControlStateNormal];
//        [self.circle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.circle.titleLabel.font = [UIFont systemFontOfSize:14];
//
//        [self.circle addTarget:self action:@selector(onReset:) forControlEvents:UIControlEventTouchUpInside];
//
//        /**
//         *  progress 完成时候的回调
//         */
//        weakly(self)
//        [self.circle startAnimationDuration:30 withBlock:^{
//            [_ onReset:_];
//        }];
//
//        [self.view addSubview:self.circle];
//    }
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
//
    self.circle.progress = progress;
}

- (IBAction)onReset:(id)sender {
//    self.progress = 0;
}

- (IBAction)onIncrease:(id)sender {
//    CGFloat progress = self.progress;
//
//    progress += 0.1;
//    progress = progress > 1.f ? 1.f : progress;
//    self.progress = progress;
}

- (IBAction)onDecrease:(id)sender {
//    CGFloat progress = self.progress;
//
//    progress -= 0.1;
//    progress = progress < 0.f ? 0.f : progress;
//    self.progress = progress;
}

- (IBAction)onPlay:(id)sender {
    {
        if (self.timer) {
            return;
        }

#define MAX_INTERVAL 30.f
        weakly(self)
        self.timer = [[_CountDown alloc] initWithDuration:MAX_INTERVAL];
        self.timer.interval = 0.03;
        [self.timer start:^(NSTimeInterval timeLeft) {
            _.progress = 1 - timeLeft/MAX_INTERVAL;
        } completion:^{
            _.progress = 0;
            _.timer = nil;
        }];
    }
}

- (IBAction)onPause:(id)sender {
    [self.timer pause];
}

- (IBAction)onResume:(id)sender {
    [self.timer resume];
}

- (IBAction)onStop:(id)sender {
    [self.timer stop];
    self.timer = nil;
}

@end
