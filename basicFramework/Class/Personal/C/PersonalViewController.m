//
//  PersonalViewController.m
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import "PersonalViewController.h"
#import "SettingViewController.h"


@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** 导航栏  */
    [self setupnav];
}

- (void)setupnav {
    
    self.navigationItem.title = @"个人设置";
    
    
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImageName:[UIImage imageNamed:@"mine-setting-icon"]
                                                    highImageName:[UIImage imageNamed:@"mine-setting-icon-click"]
                                                           target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItem = setting;
    
}

- (void)settingClick {
    
    SettingViewController *vc = [[SettingViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
