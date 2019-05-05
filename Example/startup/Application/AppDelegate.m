//
//  AppDelegate.m
//  startup
//
//  Created by 7 on 22/12/2017.
//  Copyright © 2017 7. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Usage.h"
#import "MainViewController.h"
#import "_Foundation.h"
#import "_NetworkLit.h"
// 登录、分享、支付
#import <_Modules/SNService.h>
#import <_Modules/_Cache.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *mainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    [self.window makeKeyAndVisible];
    
    //////////////////////////////
    
    [self usageOfReachability];
    
//    [[_UnitTest sharedInstance] run];
    
    //////////////////////////////
    
    ////////////// 三方登录
    
    service.sns.wechat.config.key = @"";
    service.sns.wechat.config.secret = @"";
    service.sns.wechat.config.redirect = @"";
    
    [service.sns configure];
    
    
    ////////////// 使用说明
    
    [self usageOfReachability];
    
    [self usageOfCache];
    
    [self usageOfDeviceInfo];
    
    [self usageOfText];
    
    [self usageOfCategory];

    //////////////
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// MARK: - App间回调

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [service.sns handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [service.sns handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [service.sns handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
