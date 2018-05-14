//
//  LYAppearanceThemeManager.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/9.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYAppearanceThemeManager.h"
#import "LYDefaultViewController.h"
#import <UIKit/UIKit.h>

NSString * const LYApprearanceThemeKey = @"LYApprearanceThemeKey";
NSString * const LYAppearanceThemeChangeNotification = @"LYAppearanceThemeChangeNotification";

@implementation LYAppearanceThemeManager

+ (instancetype)shareManager {
    static LYAppearanceThemeManager *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LYAppearanceThemeManager alloc] init];
    });
    
    return _instance;
}

#pragma mark - Public Method

- (void)updateTheme {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LYApprearanceThemeKey]) {
        
        switch ([[[NSUserDefaults standardUserDefaults] objectForKey:LYApprearanceThemeKey] integerValue]) {
            case LYAppearanceThemeTypeDefault:
                [self p_lyThemeSettingDefault];
                break;
            case LYAppearanceThemeTypeNight:
                [self p_lyThemeSettingNight];
                break;
            case LYAppearanceThemeTypeValue1:
                [self p_lyThemeSettingValue1];
                break;
            case LYAppearanceThemeTypeValue2:
                [self p_lyThemeSettingValue2];
                break;
        }
    } else {
        [self p_lyThemeSettingDefault];
    }
    
    [self p_updateSystemWindow];
}


#pragma mark - PrivateMethod

- (void)p_lyThemeSettingDefault {
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor redColor]];
    [[UITabBar appearance] setTintColor:[UIColor yellowColor]];
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
}

- (void)p_lyThemeSettingNight {
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor brownColor]];
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
}

- (void)p_lyThemeSettingValue1 {
    [[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor greenColor]];
    [[UITabBar appearance] setTintColor:[UIColor yellowColor]];
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
    [[UILabel appearance] setTextColor:[UIColor brownColor]];
}

- (void)p_lyThemeSettingValue2 {
    [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blueColor]];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UILabel appearance] setTextColor:[UIColor yellowColor]];
}

- (void)p_updateSystemWindow {
    NSArray *windowArray = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windowArray) {
        for (UIView *subView in window.subviews) {
            [subView removeFromSuperview];
            [window addSubview:subView];
        }
    }
}

#pragma mark - Setter

- (void)setThemeType:(LYAppearanceThemeType)themeType {
    [[NSUserDefaults standardUserDefaults] setObject:@(themeType) forKey:LYApprearanceThemeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:LYAppearanceThemeChangeNotification object:nil];
    
    [self updateTheme];
}

@end
