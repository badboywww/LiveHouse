//
//  DRCommonRetryLoadView.h
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCommonRetryLoadView : UIView

/**
 类初始化方法
 
 @return 返回实例对象
 */
+ (instancetype)retryLoadView;

- (void)show;
- (void)dismiss;

/**
 触发重新连接

 @param retryConnectionActionBlock 重新连接按钮触发后的回调
 */
- (void)triggerRetryConnectActionBlock:(void(^)(void))retryConnectionActionBlock;

/**
 显示在哪个父视图中

 @param containerView 父视图
 @param navigationViewController 导航控制器
 */
- (void)showInView:(UIView *)containerView navigationViewController:(UINavigationController *)navigationViewController;

@end

NS_ASSUME_NONNULL_END
