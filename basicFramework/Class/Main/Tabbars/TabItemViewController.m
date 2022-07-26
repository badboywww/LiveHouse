//
//  TabItemViewController.m
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import "TabItemViewController.h"

@interface TabItemViewController ()

@property (nonatomic, strong, nullable) TabbarControllerFBHelper *viewtimeFBHelper;

@end

@implementation TabItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)viewtimeFBEventName {
    return nil;
}

- (void)setSelected:(BOOL)selected {
    if (_selected == selected) {
        return;
    }
    _selected = selected;
    if (selected) {
        [self.viewtimeFBHelper begin];
    } else {
        [self.viewtimeFBHelper end];
    }
}

- (BOOL)overrideTabbarCameraAction {
    return NO;
}

#pragma mark LAYZY LOAD
- (TabbarControllerFBHelper *)viewtimeFBHelper {
    if (self.viewtimeFBEventName.length == 0) {
        return nil;
    }
    
    if (!_viewtimeFBHelper) {
        _viewtimeFBHelper = [[TabbarControllerFBHelper alloc]init];
    }
    return _viewtimeFBHelper;
}

@end
