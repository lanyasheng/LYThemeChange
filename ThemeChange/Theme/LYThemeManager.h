//
//  LYThemeManager.h
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/8.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYThemeChangeType) {
    LYThemeChangeTypeDefault = 0,
    LYThemeChangeTypeNight,
    LYThemeChangeTypeValue1,
    LYThemeChangeTypeValue2
};

extern NSString * const LYThemeChangeNotification;
extern NSString * const LYThemeChangeKey;

@interface LYThemeManager : NSObject

@property (nonatomic, assign) LYThemeChangeType themeType;


+ (instancetype)shareManager;
- (UIColor *)colorWithReceiver:(id)receiver selString:(NSString *)selector;
- (UIColor *)colorWithReceiver:(id)receiver withTag:(NSInteger)tag selString:(NSString *)selector;

@end

