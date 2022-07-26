//
//  DRBaseVC.h
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "DRCommonRetryLoadView.h""

NS_ASSUME_NONNULL_BEGIN

@interface DRBaseVC : UIViewController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, strong, nullable) UIButton *navLeftButton;
@property (nonatomic, strong, nullable) UIButton *navRightButton;
@property (nonatomic, strong, nullable) UIView *navBottomLine;
@property (nonatomic, strong, nullable) DRCommonRetryLoadView *retryLoadView; //重新加载视图
@property (nonatomic, weak, nullable) UIView *retryLoadViewSuperView;
/// 默认导航栏样式 没有分割线 YES
@property (nonatomic, assign) BOOL isNormalNavBar;
@property (nonatomic, strong, nullable) RACDisposable *racDisposable;

/// 来源
@property (nonatomic, strong) NSString *fromPage;

@property (nonatomic, assign) BOOL preferNavigationBarHidden;

/// 初始化代表来源
/// @param fromPage 来源页面
- (instancetype _Nullable)initWithFromPage:(NSString *)fromPage;

- (void)createNavigationButtonWithImage:(NSString *)imageName
                          selectedImage:(NSString * _Nullable)selectedImageName
                                 onLeft:(BOOL)isLeft
                              withBlock:(DefaultBlock)block;

- (void)base_retryLoadData; //重新加载数据,子类可重载
- (void)base_headerRefreshFail;
- (void)base_removeRetryLoadView; //移除该视图，子类可直接调用
/**
 取消上一次网络请求
 */
- (void)base_cancelLastAPIRequest;

// 埋点
//view time
- (void)fb_viewTime:(NSInteger)viewTime;

//隐藏和显示statusBar
- (void)setStatusBarHidden:(BOOL)hidden;

- (void)customPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
