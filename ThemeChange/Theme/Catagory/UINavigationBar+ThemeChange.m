//
//  UINavigationBar+ThemeChange.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/10.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "UINavigationBar+ThemeChange.h"
#import "LYMethodSwizzleUtils.h"
#import "UIView+ThemeChange.h"
#import "LYThemeManager.h"

@interface UINavigationBar ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end
@implementation UINavigationBar (ThemeChange)

+ (void)load {
    [self swizzleNavColor];
}

+ (void)swizzleNavColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBarTintColor:) swappedMethod:@selector(ly_setBarTintColor:)];
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTintColor:) swappedMethod:@selector(ly_setNavTintColor:)];
    });
}

- (void)ly_setBarTintColor:(UIColor *)color {
    UIColor *barTintColor = [[LYThemeManager shareManager] colorWithReceiver:self selString:@"setBarTintColor:"];
    if (barTintColor) {
        [self ly_setBarTintColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBarTintColor:"];
    } else {
        [self ly_setBarTintColor:color];
    }
}

- (void)ly_setNavTintColor:(UIColor *)color {
    UIColor *tintColor = [[LYThemeManager shareManager] colorWithReceiver:self selString:@"setNavTintColor:"];
    if (tintColor) {
        [self ly_setNavTintColor:tintColor];
        [self.pickers setObject:tintColor forKey:@"setTintColor:"];
    } else {
        [self ly_setNavTintColor:color];
    }
}

@end
