//
//  WaveProgressViewController.m
//  startup
//
//  Created by fallen.ink on 2019/5/1.
//  Copyright © 2019 7. All rights reserved.
//

#import <Framework/WaveProcessView.h>
#import "WaveProgressViewController.h"

@interface WaveProgressViewController ()

@end

@implementation WaveProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaveProcessView *_customView =
    [WaveProcessView createForZhangHengWithFrame:CGRectMake(0, 0, 40, 40)
                                         percent:0.6
                                     borderWidth:2
                                     borderColor:color_with_hex(0xE6C289)
                                 foregroundColor:color_with_hex(0xE6C289)
                                 backgroundColor:color_white];

    [self.view addSubview:_customView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
