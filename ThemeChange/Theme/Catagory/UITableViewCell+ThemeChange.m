//
//  UITableViewCell+ThemeChange.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/14.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "UITableViewCell+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "LYThemeManager.h"
#import "LYMethodSwizzleUtils.h"

@interface UITableViewCell ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UITableViewCell (ThemeChange)

+ (void)load {
    [self swizzleTableViewCellColor];
}

+ (void)swizzleTableViewCellColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(ly_setTableViewCellBackgroundColor:)];
    });
}

- (void)ly_setTableViewCellBackgroundColor:(UIColor *)color {
    UIColor *barTintColor = [[LYThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:[NSString stringWithFormat:@"%ld:tableViewCellBackgroundColor", (long)self.tag]];
    if (barTintColor) {
        [self ly_setTableViewCellBackgroundColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBackgroundColor:"];
    } else {
        [self ly_setTableViewCellBackgroundColor:color];
    }
}

@end
