//
//  LYThemeManager.m
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYThemeManager.h"
#import "UIColor+LYTools.h"

NSString * const LYThemeChangeNotification = @"LYThemeChangeNotification";
NSString * const LYThemeChangeKey = @"LYThemeChangeKey";

@interface LYThemeManager ()

@property (nonatomic, strong) NSDictionary *colorInfoDic;
@property (nonatomic, strong) NSDictionary *specialColorInfoDic;

@end
@implementation LYThemeManager

+ (instancetype)shareManager {
    static LYThemeManager *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LYThemeManager alloc] init];
        LYThemeChangeType type = [[[NSUserDefaults standardUserDefaults] valueForKey:LYThemeChangeKey] integerValue];
        type = type ?: LYThemeChangeTypeDefault;
        _instance.themeType = type;
    });
    
    return _instance;
}

- (void)setThemeType:(LYThemeChangeType)themeType {
    _themeType = themeType;
    
    NSString *path = nil;
    NSString *tagPath = nil;
    switch (themeType) {
        case LYThemeChangeTypeDefault:
            {
                path = [[NSBundle mainBundle] pathForResource:@"LYThemeDefault" ofType:@"plist"];
                tagPath = [[NSBundle mainBundle] pathForResource:@"LYThemeDefaultTag" ofType:@"plist"];
            }
            break;
        case LYThemeChangeTypeNight:
            {
                path = [[NSBundle mainBundle] pathForResource:@"LYThemeNight" ofType:@"plist"];
                tagPath = [[NSBundle mainBundle] pathForResource:@"LYThemeNightTag" ofType:@"plist"];
            }
            break;
        case LYThemeChangeTypeValue1:
            break;
        case LYThemeChangeTypeValue2:
            break;
    }
    
    _colorInfoDic = [NSDictionary dictionaryWithContentsOfFile:path];
    _specialColorInfoDic = [NSDictionary dictionaryWithContentsOfFile:tagPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LYThemeChangeNotification object:nil];
    
}

- (UIColor *)colorWithReceiver:(id)receiver selString:(NSString *)selector {
    
    UIColor *color = [UIColor colorWithHexString:[_colorInfoDic objectForKey:selector]];
    
    return color;
}

- (UIColor *)colorWithReceiver:(id)receiver withTag:(NSInteger)tag selString:(NSString *)selector {
    
    UIColor *color = nil;
    if ([_specialColorInfoDic objectForKey:selector]) {
        color = [UIColor colorWithHexString:[_specialColorInfoDic objectForKey:selector]];
    }
    
    return color;
}

@end

