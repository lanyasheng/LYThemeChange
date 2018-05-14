//
//  UIColor+LYTools.h
//  LaunchScreenTest
//
//  Created by shenglanya on 2018/5/10.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYTools)

+ (UIColor *)colorWithHexString:(NSString *)string;

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

@end
