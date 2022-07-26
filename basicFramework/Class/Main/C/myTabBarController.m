//
//  myTabBarController.m
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import "myTabBarController.h"

#import "HomeViewController.h"     //主页
#import "PublishViewController.h"  //发布
#import "NewViewController.h"      //新页
#import "FriendViewController.h"   //关注
#import "PersonalViewController.h" //个人

@interface myTabBarController()

/** center */
@property (nonatomic, weak) UIButton * plusButton;

@end

@implementation myTabBarController

+(void)load {
    //获取外观
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
}

/** center 按钮  */
- (UIButton *)plusButton {
    
    if (!_plusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.center = CGPointMake(self.tabBar.bounds.size.width * 0.5 , self.tabBar.bounds.size.height * 0.5);
        //        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }
    
    return _plusButton;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /** 导航栏字体颜色  */
    self.tabBar.tintColor = [UIColor blackColor];
    
    self.plusButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5 , self.tabBar.bounds.size.height * 0.5);
    
    /** 添加子控制器  */
    [self setAddChildVc];
    
    /** 设置TabBar的所有按钮  */
    [self setTabBarItem];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
}

- (void)setTabBarItem {
    
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"主页";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_new_click_icon"];
    
    UIViewController *vc = self.childViewControllers[2];
    vc.tabBarItem.enabled = NO;
    
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"个人";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_me_click_icon"];
    
}

#pragma mark 添加所有子控制器
- (void)setAddChildVc {
    
    //主页
    HomeViewController *Vc0 = [[HomeViewController alloc]init];
    myNavigationController *Nav0 = [[myNavigationController alloc]initWithRootViewController:Vc0];
    [self addChildViewController:Nav0];
    
    //新页
    NewViewController *Vc1 = [[NewViewController alloc]init];
    myNavigationController *Nav1 = [[myNavigationController alloc]initWithRootViewController:Vc1];
    [self addChildViewController:Nav1];
    
    //发布
    PublishViewController *Vc2 = [[PublishViewController alloc]init];
    [self addChildViewController:Vc2];
    
    //关注
    FriendViewController *Vc3 = [[FriendViewController alloc]init];
    myNavigationController *Nav2 = [[myNavigationController alloc]initWithRootViewController:Vc3];
    [self addChildViewController:Nav2];
    
    //个人
    PersonalViewController *Vc4 = [[PersonalViewController alloc]init];
    myNavigationController *Nav3 = [[myNavigationController alloc]initWithRootViewController:Vc4];
    [self addChildViewController:Nav3];
    
}

@end
