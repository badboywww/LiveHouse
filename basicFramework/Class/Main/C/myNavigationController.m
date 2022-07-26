//
//  myNavigationController.m
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import "myNavigationController.h"

@interface myNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation myNavigationController

+ (void)load {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    bar.titleTextAttributes = attr;
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //禁止系统手势代理 实现侧滑返回
    self.interactivePopGestureRecognizer.enabled = NO;
    
    id target = self.interactivePopGestureRecognizer.delegate;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    
    myNavigationBar *bar = [[myNavigationBar alloc]initWithFrame:self.navigationBar.frame];
    
    [self.view addGestureRecognizer:pan];
    
    [self setValue:bar forKey:@"navigationBar"];
    
}

//返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.childViewControllers.count > 0) {
        
        backView *view = [backView backViewWithImageName:[UIImage imageNamed:@"navigationButtonReturn"] highImageName:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self Action:@selector(backAction) Title:@"返回"];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backAction {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return self.childViewControllers.count > 1;
}


@end
