//
//  LYAppearanceThemeManager.h
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/9.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LYAppearanceThemeType) {
    LYAppearanceThemeTypeDefault,
    LYAppearanceThemeTypeNight,
    LYAppearanceThemeTypeValue1,
    LYAppearanceThemeTypeValue2
};


extern NSString * const LYApprearanceThemeKey;
extern NSString * const LYAppearanceThemeChangeNotification;

@interface LYAppearanceThemeManager : NSObject

@property (nonatomic, assign) LYAppearanceThemeType themeType;

+ (instancetype)shareManager;

- (void)updateTheme;

@end
