//
//  LYTableViewController.m
//  ThemeChange
//
//  Created by shenglanya on 2018/5/13.
//  Copyright © 2018年 shenglanya. All rights reserved.
//

#import "LYTableViewController.h"
#import "LYAppearanceThemeManager.h"
#import "LYThemeManager.h"

static NSString * const kTableViewReusableCellId = @"kTableViewReusableCellId";
static NSString * const kThemeChangeReusableCellId = @"kThemeChangeReusableCellId";

@interface LYThemeChangeTableViewCell ()

@property (nonatomic, strong) UISwitch *switchView;

@end
@implementation LYThemeChangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if ([reuseIdentifier isEqualToString:kThemeChangeReusableCellId]) {
            [self setUpData];
            
                        if ([LYAppearanceThemeManager shareManager].themeType == LYAppearanceThemeTypeNight) {
                            _switchView.on = YES;
                        } else {
                            _switchView.on = NO;
                        }
        }
    }
    return self;
}

- (void)setUpData {
    _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
    [self.contentView addSubview:_switchView];
    [_switchView addTarget:self action:@selector(didChangeValueForSwitchView) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Response Method

- (void)didChangeValueForSwitchView {
    if (self.switchView.isOn) {
        [[NSUserDefaults standardUserDefaults] setObject:@(LYThemeChangeTypeNight) forKey:LYThemeChangeKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@(LYThemeChangeTypeDefault) forKey:LYThemeChangeKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [LYThemeManager shareManager].themeType = [[[NSUserDefaults standardUserDefaults] objectForKey:LYThemeChangeKey] intValue];
    
//        if (self.switchView.isOn) {
//            [[LYAppearanceThemeManager shareManager] setThemeType:LYAppearanceThemeTypeNight];
//        } else {
//            [[LYAppearanceThemeManager shareManager] setThemeType:LYAppearanceThemeTypeDefault];
//        }
}

- (void)setTextColor:(UIColor *)textColor {
    self.textLabel.textColor = textColor;
}

@end

@interface LYTableViewController ()

@end

@implementation LYTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tag = BackgroundViewColorTag;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setUpData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup data

- (void)setUpData {
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    } else {
        return 20;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:kTableViewReusableCellId];
        if (!cell) {
            cell = [[LYThemeChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewReusableCellId];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kThemeChangeReusableCellId];
        if (!cell) {
            cell = [[LYThemeChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kThemeChangeReusableCellId];
        }
    }
    
    cell.tag = TableViewCellBackgroundColorTag;
    cell.textLabel.tag = TableViewCellTextColorTag;
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.backgroundColor = [UIColor yellowColor];
 
    return cell;
}

@end
