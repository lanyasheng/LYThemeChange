//
//  LYNavigationController.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/13.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYNavigationController.h"

@interface LYNavigationController ()

@end

@implementation LYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.view.tag = BackgroundViewColorTag;
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
