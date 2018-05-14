//
//  LYTabbarController.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/13.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYTabbarController.h"
#import "LYNavigationController.h"
#import "LYDefaultViewController.h"
#import "LYTableViewController.h"
#import "UIColor+LYTools.h"

static NSInteger DEFAULTCONTROLLERCOUNT = 4;

@interface LYTabbarController ()

@end

@implementation LYTabbarController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.barTintColor = [UIColor redColor];
    self.tabBar.tintColor = [UIColor blueColor];
    
    self.tabBar.layer.borderColor = [UIColor redColor].CGColor;
    self.tabBar.tag = 0041;
    self.view.tag = BackgroundViewColorTag;
    
    [self setUpControllerData];
    [self setUpTabbarData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupData

- (void)setUpControllerData {
    NSMutableArray <LYNavigationController *> *controllers = @[].mutableCopy;
    for (int i = 0; i < DEFAULTCONTROLLERCOUNT - 1; ++i) {
        LYDefaultViewController *defaultViewController = [[LYDefaultViewController alloc] init];
        defaultViewController.title = [NSString stringWithFormat:@"%d controller", i];
        [controllers addObject:[[LYNavigationController alloc] initWithRootViewController:defaultViewController]];
    }
    LYTableViewController *tableViewController = [[LYTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableViewController.title = @"tableView";
    [controllers addObject:[[LYNavigationController alloc] initWithRootViewController:tableViewController]];
    
    self.viewControllers = controllers.copy;
}

- (void)setUpTabbarData {
    NSArray <NSString *> *itemString = @[@"Dynamic", @"Location", @"Alert", @"Me"];
    for (int i = 0; i < DEFAULTCONTROLLERCOUNT; ++i) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:itemString[i] image:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_%d", i + 1]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_%d_select", i + 1]]];
        
        self.viewControllers[i].tabBarItem = item;
    }
}

@end
