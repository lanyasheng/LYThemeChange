//
//  LYDefaultViewController.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/13.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYDefaultViewController.h"

@interface LYDefaultViewController ()

@end

@implementation LYDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.tag = BackgroundViewColorTag;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
