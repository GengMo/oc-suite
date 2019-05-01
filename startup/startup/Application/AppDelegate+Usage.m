//
//  AppDelegate+Usage.m
//  startup
//
//  Created by 7 on 2018/4/28.
//  Copyright © 2018 7. All rights reserved.
//

#import "AppDelegate+Usage.h"
#import "_Reachability.h"
#import "_Cache.h"

@implementation AppDelegate (Usage)

- (void)usageOfReachability {
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach) {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach) {
        NSLog(@"UNREACHABLE!");
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}

- (void)usageOfCache {
    cacheInst[@"key"] = @(10);
    
    LOG(@"cache[key] = %@", cacheInst[@"key"]);
    
    INFO(@"the @key8888 = %@", shared_cache[@"key"]);
    
    shared_cache[@"key"] = @"dddd";
    NSString *value = shared_cache[@"key"];
    INFO(@"the @key = %@", value);
}

- (void)usageOfDeviceInfo {
    INFO(@"====== Device Info ======")
    
    INFO(@"Hardware description = %@", shared_device.hardwareDescription)
    
    INFO(@"=========================\n")
}

- (NSUInteger)textLength_AChnAsTwoChars:(NSString *)text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    return unicodeLength;
}


- (void)usageOfText {
    INFO(@"======= Text Info =======")
    
    NSString *str = @"我520";
    
    INFO(@"%@ lenth = %@", str, @([self textLength_AChnAsTwoChars:str]))
    
    
    INFO(@"=========================\n")
}

//static const void *JKTextFieldInputLimitMaxLength = &JKTextFieldInputLimitMaxLength;
//- (NSInteger)maxLength {
//    return (NSInteger)objc_getAssociatedObject(self, JKTextFieldInputLimitMaxLength);
//}
//- (void)setMaxLength:(NSInteger)maxLength {
//    objc_setAssociatedObject(self, JKTextFieldInputLimitMaxLength, (__bridge id _Nullable)((void *)maxLength), OBJC_ASSOCIATION_ASSIGN);
//}

- (void)usageOfCategory {
//    self.maxLength = 100;
    
//    INFO(@"category maxLength = %@", self.maxLength)
}

@end
