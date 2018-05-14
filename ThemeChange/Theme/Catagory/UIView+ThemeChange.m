//
//  UIView+ThemeChange.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "UIView+ThemeChange.h"
#import "LYMethodSwizzleUtils.h"
#import <objc/runtime.h>
#import "LYThemeManager.h"

@interface UIView ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UIView (ThemeChange)

+ (void)load {
    [self swizzleViewColor];
}

#pragma mark - MethodSwizzling

+ (void)swizzleViewColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(ly_setBackgroundColor:)];
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTintColor:) swappedMethod:@selector(ly_setTintColor:)];
    });
}

- (void)ly_setBackgroundColor:(UIColor *)color {
    
        // 利用 selector 来选方法,注意子类和父类不要使用同名方法，否则会导致符号混乱产生循环引用。
    UIColor *bgColor = [[LYThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:[NSString stringWithFormat:@"%ld:viewBackgroundColor", self.tag]];
    if (bgColor) {
        [self.pickers setObject:bgColor forKey:@"setBackgroundColor:"];
        [self ly_setBackgroundColor:bgColor];
    } else {
        [self ly_setBackgroundColor:color];
    }
}

- (void)ly_setTintColor:(UIColor *)color {
    UIColor *tintColor = [[LYThemeManager shareManager] colorWithReceiver:self selString:@"setTintColor:"];
    if (tintColor) {
        [self.pickers setObject:tintColor forKey:@"setTintColor:"];
        [self ly_setTintColor:tintColor];
    } else {
        [self ly_setTintColor:color];
    }
}

#pragma mark - Add Property

- (NSMutableDictionary<NSString *,UIColor *> *)pickers {
    NSMutableDictionary <NSString *, UIColor *> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        pickers = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:LYThemeChangeNotification object:nil];
    }
    return pickers;
}

#pragma mark - Response Notification

- (void)updateTheme {
    
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString(key);
        [UIView animateWithDuration:0.3 animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:obj];
#pragma clang diagnostic pop
        }];
    }];
}

@end
