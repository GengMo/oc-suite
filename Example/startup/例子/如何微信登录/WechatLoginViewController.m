//
//  WechatLoginViewController.m
//  startup
//
//  Created by fallen.ink on 2019/4/1.
//  Copyright © 2019 7. All rights reserved.
//

#import "WechatLoginViewController.h"
#import <Framework/SNService.h>

@interface WechatLoginViewController ()

@end

@implementation WechatLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 微信登录
    [service.sns.wechat
     loginWithContext:self
     success:^(id  _Nullable obj) {
         NSDictionary *resp = obj;
         
         NSLog(@" code: %@", resp[@"code"]);
     } failure:^(NSError * _Nullable error) {
         
     }];
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
