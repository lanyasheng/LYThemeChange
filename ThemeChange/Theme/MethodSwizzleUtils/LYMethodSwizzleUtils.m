//
//  LYMethodSwizzleUtils.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYMethodSwizzleUtils.h"

@implementation LYMethodSwizzleUtils

+ (void)swizzleInstanceMethodWithClass:(Class)originClass
                          OriginMethod:(SEL)originMethod
                         swappedMethod:(SEL)swappedMethod {
    
    SEL originalSelector = originMethod;
    SEL swappedSelector = swappedMethod;
    
    Method originalMethod = class_getInstanceMethod(originClass, originalSelector);
    Method newMethod = class_getInstanceMethod(originClass, swappedSelector);
    
    BOOL didAddMethod = class_addMethod(originClass, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(originClass, swappedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

+ (void)swizzleClassMethodWithClass:(Class)originClass
                       OriginMethod:(SEL)originMethod
                      swappedMethod:(SEL)swappedMethod {
    SEL originalSelector = originMethod;
    SEL swappedSelector = swappedMethod;
    
    Method originalMethod = class_getClassMethod(originClass, originalSelector);
    Method newMethod = class_getClassMethod(originClass, swappedSelector);
    
    BOOL didAddMethod = class_addMethod(originClass, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(originClass, swappedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end
