//
//  UITableView+ThemeChange.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/14.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "UITableView+ThemeChange.h"
#import "LYMethodSwizzleUtils.h"
#import "UIView+ThemeChange.h"
#import "LYThemeManager.h"

@interface UITableView ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end
@implementation UITableView (ThemeChange)

+ (void)load {
    [self swizzleTableViewColor];
}

+ (void)swizzleTableViewColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LYMethodSwizzleUtils swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(ly_setTableViewBackgroundColor:)];
    });
}

- (void)ly_setTableViewBackgroundColor:(UIColor *)color {
    UIColor *barTintColor = [[LYThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:@"setTableViewBackgroundColor:"];
    if (barTintColor) {
        [self ly_setTableViewBackgroundColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBackgroundColor:"];
    } else {
        [self ly_setTableViewBackgroundColor:color];
    }
}

@end
