//
//  AppDelegate.h
//  startup
//
//  Created by 7 on 22/12/2017.
//  Copyright © 2017 7. All rights reserved.
//

#import <UIKit/UIKit.h>

// 这里引用大部分头文件依赖，所以其他页面代码，可以依赖 ‘AppDelegate.h’

#import <Framework/_Foundation.h>
#import <Framework/_UIKit.h>
#import <Framework/_NetworkLit.h>
#import <Framework/_Cache.h>
#import <YYModel/YYModel.h>
#import <SDWebImage/SDWebImageManager.h>
#import "UIImageView+WebCache.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

