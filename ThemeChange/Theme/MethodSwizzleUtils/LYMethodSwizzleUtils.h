//
//  LYMethodSwizzleUtils.h
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface LYMethodSwizzleUtils : NSObject

+ (void)swizzleInstanceMethodWithClass:(Class)originClass
                          OriginMethod:(SEL)originMethod
                         swappedMethod:(SEL)swappedMethod;

+ (void)swizzleClassMethodWithClass:(Class)originClass
                       OriginMethod:(SEL)originMethod
                      swappedMethod:(SEL)swappedMethod;

@end
