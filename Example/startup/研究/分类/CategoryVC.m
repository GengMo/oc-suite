//
//  CategoryVC.m
//  startup
//
//  Created by fallen.ink on 2019/12/10.
//  Copyright © 2019 7. All rights reserved.
//

#import "CategoryVC.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

// 知识点
// 1. https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html
//      If the name of a method declared in a category is the same as a method in the original class, or a method in another category on the same class (or even a superclass), the behavior is undefined as to which method implementation is used at runtime.
// 2. 如何调用原始类的test方法？
//      目前只能索引到最后一个方法，当作是原始类的方法调用？基于 1, 这些并没有确定的调用规则，所以探讨其规则是没有意义的
// 3. 先调用哪个分类的方法呢？【实践，依赖运行时的实现方案!!!不是真理！！】
//      如果两个分类在一个文件里，在后面的会被先被调用；同等，如果是多个文件，那后被加载的先被调用


// MARK: - 测试类 B

@interface CategoryVC (B)

- (void) test;

@end

@implementation CategoryVC (B)

- (void)test {
    LOG(@"CategoryVC B test invoked");
}

@end

// MARK: - 测试类 C

@interface CategoryVC (C)

- (void) test;

@end

@implementation CategoryVC (C)

- (void)test {
    LOG(@"CategoryVC C test invoked");
    
}

@end


// MARK: -
@interface CategoryVC ()

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    
    [self getAllMethods];
}

- (void)getAllMethods {
    NSArray *allMethods = [self.class methods];
    NSArray *allMethodInfo = [self.class methodsInfo];

    
    LOG(@"CategoryVC getAllMethods invoked, %@", [allMethods descriptionWithLocale:nil indent:1]);
    LOG(@"CategoryVC getAllMethods invoked, %@", [allMethodInfo descriptionWithLocale:nil indent:1]);
}

- (void)test {
    LOG(@"CategoryVC test invoked");
}

@end
