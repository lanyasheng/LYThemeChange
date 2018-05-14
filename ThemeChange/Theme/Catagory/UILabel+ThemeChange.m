//
//  UILabel+ThemeChange.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "UILabel+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "LYMethodSwizzleUtils.h"
#import "LYThemeManager.h"

@interface UILabel ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end
@implementation UILabel (ThemeChange)

+ (void)load {
    [self swizzleLabelTextColor];
}

+ (void)swizzleLabelTextColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTextColor:) swappedMethod:@selector(ly_setTextColor:)];
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setHighlightedTextColor:) swappedMethod:@selector(ly_setHighlightedTextColor:)];
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setShadowColor:) swappedMethod:@selector(ly_setShadowColor:)];
    });
}

- (void)ly_setTextColor:(UIColor *)color {
    UIColor *textColor = [[LYThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:[NSString stringWithFormat:@"%ld:textColor", self.tag]];
    if (textColor) {
        [self ly_setTextColor:textColor];
        [self.pickers setObject:textColor forKey:@"setTextColor:"];
    } else {
        [self ly_setTextColor:color];
    }
}

- (void)ly_setHighlightedTextColor:(UIColor *)color {
    UIColor *highlightColor = [[LYThemeManager shareManager] colorWithReceiver:self selString:@"setHighlightedTextColor:"];
    if (highlightColor) {
        [self ly_setHighlightedTextColor:highlightColor];
        [self.pickers setObject:highlightColor forKey:@"setHighlightedTextColor:"];
    } else {
        [self ly_setHighlightedTextColor:color];
    }
}

- (void)ly_setShadowColor:(UIColor *)color {
    UIColor *shadowColor = [[LYThemeManager shareManager] colorWithReceiver:self selString:@"setShadowColor:"];
    if (shadowColor) {
        [self ly_setShadowColor:shadowColor];
        [self.pickers setObject:shadowColor forKey:@"setShadowColor:"];
    } else {
        [self ly_setShadowColor:color];
    }
}


@end
