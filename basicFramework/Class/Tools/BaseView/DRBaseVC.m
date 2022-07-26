//
//  DRBaseVC.m
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import "DRBaseVC.h"

static NSString *const kTitleFontName = @"PingFangSC-Medium";
@interface DRBaseVC ()
@property (nonatomic, assign) BOOL hideStatusBar;
@end

@implementation DRBaseVC

- (void)dealloc {
    [self base_cancelLastAPIRequest];
    [self fb_viewTime:[self endRecordViewTime]];
}

/// 初始化代表来源
/// @param fromPage 来源页面
- (instancetype)initWithFromPage:(NSString *)fromPage {
    self = [super init];
    if (self) {
        self.fromPage = fromPage;
        if (self.fromPage == nil) {
            self.fromPage = @"";
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferNavigationBarHidden = NO;
    _statusBarStyle = UIStatusBarStyleDefault;
    [self beginRecordViewTime];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor dr_colorDynamicWithLight:0xffffff Dark:0x1f1e1e];
    self.isNormalNavBar = YES;

    UIFont *font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: font,
                                          NSForegroundColorAttributeName: [UIColor dr_colorDynamicWithLight:0x323233 Dark:0xffffff]};
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        appearance.backgroundColor = [UIColor dr_colorDynamicWithLight:0xffffff Dark:0x333333];
        appearance.titleTextAttributes = titleTextAttributes;
        appearance.shadowColor = UIColor.clearColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    self.navigationController.navigationBar.backgroundColor = [UIColor dr_colorDynamicWithLight:0xffffff Dark:0x333333];
    
    [self initCommonUI];
    
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)fb_viewTime:(NSInteger)viewTime {
    //子类重写这个方法来埋点
}

- (void)initCommonUI {
    self.navBottomLine = [[UIView alloc] init];
    self.navBottomLine.backgroundColor = [UIColor dr_colorDynamicWithLight:0xCACACA Dark:0x383636];
    self.navBottomLine.hidden = YES;
    [self.view addSubview:self.navBottomLine];
    [self.navBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.offset(0);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isNormalNavBar) {
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.barTintColor = [UIColor dr_colorDynamicWithLight:0xffffff Dark:0x1f1e1e];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.navigationController.navigationBar.translucent = YES;
    }
    if (self.navLeftButton) {
        self.navLeftButton.userInteractionEnabled = YES;
    }
    if (self.navRightButton) {
        self.navRightButton.userInteractionEnabled = YES;
    }
    [self.navigationController setNavigationBarHidden:self.preferNavigationBarHidden animated:YES];
}

- (void)createNavigationButtonWithImage:(NSString *)imageName
                          selectedImage:(NSString *)selectedImageName
                                 onLeft:(BOOL)isLeft
                              withBlock:(DefaultBlock)block {
//    if ([YSLocalizableUtil isSystemArb]) {
//        if ([imageName isEqualToString:@"common_back"]) {
//            imageName = @"anti_back";
//        }
//        if ([selectedImageName isEqualToString:@"common_back"]) {
//            selectedImageName = @"anti_back";
//        }
//    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectedImageName.length > 0) {
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }

    if (isLeft) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -13;

        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.navLeftButton = button;
        self.navigationItem.leftBarButtonItems = @[spaceButtonItem, [[UIBarButtonItem alloc] initWithCustomView:button]];
    } else {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.navRightButton = button;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    if (block) {
        [button dr_controlTapAction:^(__kindof UIControl * _Nonnull control) {
            button.userInteractionEnabled = NO;
            block();
        }];
    }
}

#pragma mark - status bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if (_statusBarStyle == statusBarStyle) {
        return;
    }
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private Methods
- (void)base_removeRetryLoadView
{
    if (_retryLoadView) {
        [_retryLoadView dismiss];
        _retryLoadView = nil;
    }
}

#pragma mark - Public Methods
- (void)base_retryLoadData
{
    [self base_removeRetryLoadView];
}

- (void)base_headerRefreshFail
{
    [self.retryLoadView show];
}

/**
 取消上一次网络请求
 */
- (void)base_cancelLastAPIRequest
{
    if (self.racDisposable) {
        if (![self.racDisposable isDisposed]) {
            [self.racDisposable dispose];
        }
        self.racDisposable = nil;
    }
}


- (BOOL)prefersStatusBarHidden {
    return self.hideStatusBar;
}

- (void)setStatusBarHidden:(BOOL)hidden {
    self.hideStatusBar = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Getter Methods
- (DRCommonRetryLoadView *)retryLoadView
{
    if (_retryLoadView == nil) {
        _retryLoadView = [DRCommonRetryLoadView retryLoadView];
        if (self.retryLoadViewSuperView) {
            [_retryLoadView showInView:self.retryLoadViewSuperView navigationViewController:self.navigationController];
        } else {
            [_retryLoadView showInView:self.view navigationViewController:self.navigationController];
        }
        DRWeakifySelf;
        [_retryLoadView triggerRetryConnectActionBlock:^{
            DRStrongifySelf;
            [self base_retryLoadData];
        }];
    }
    return _retryLoadView;
}

- (NSString *)fromPage {
    if (_fromPage) {
        return _fromPage;
    } else {
        return @"";
    }
}

#pragma mark - Orientation
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
//    if (![viewControllerToPresent isKindOfClass:[GLOCVipBaseViewController class]] &&
//        ![self isKindOfClass:[FlowerImagePickerViewController class]]) {
//        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)customPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}


@end
