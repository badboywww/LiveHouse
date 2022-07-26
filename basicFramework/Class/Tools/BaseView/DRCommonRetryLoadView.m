//
//  DRCommonRetryLoadView.m
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import "DRCommonRetryLoadView.h"

static CGSize const kLossNetworkFlowerSize = (CGSize){70, 71};
static CGSize const kOperationBtnSize = (CGSize){150, 32};

@interface DRCommonRetryLoadView ()

@property (nonatomic, strong) UIImageView *noNetworkFlowerImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *retryConnectionBtn;
@property (nonatomic, weak) UINavigationController *navDelegate;
@property (nonatomic, strong) void(^retryConnectionActionBlock)(void);

@end

@implementation DRCommonRetryLoadView

#pragma mark - init Methods

/**
 类初始化方法
 
 @return 返回实例对象
 */
+ (instancetype)retryLoadView {
    DRCommonRetryLoadView *_instace = [[self alloc] init];
    return _instace;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
     
    self.backgroundColor = [UIColor dr_colorDynamicWithLight:0xffffff Dark:0x000000];
    
    //花
    [self addSubview:self.noNetworkFlowerImageView];
    [self.noNetworkFlowerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kLossNetworkFlowerSize);
        make.centerX.mas_equalTo(self.centerX);
        make.top.mas_equalTo(self.top).offset(GLFrameX(164));
    }];
    
    //提示
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerX);
        make.top.mas_equalTo(self.noNetworkFlowerImageView.bottom).offset(16);
    }];
    
   
    
    [self addSubview:self.retryConnectionBtn];
    [self.retryConnectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kOperationBtnSize);
        make.top.mas_equalTo(self.tipLabel.bottom).offset(31);
        make.centerX.mas_equalTo(self);
    }];
    
}

#pragma mark - Action Methods
- (void)retryConnectAction:(UIButton *)sender {
    if (self.retryConnectionActionBlock) {
        [self dismiss];
        self.retryConnectionActionBlock();
    }
}

#pragma mark - Public Methods
- (void)show {
    //啥都不干，除了显示
    self.hidden = NO;
}

- (void)dismiss; {
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)showInView:(UIView *)containerView navigationViewController:(UINavigationController *)navigationViewController {
    self.navDelegate = navigationViewController;
    //添加到容器视图上
    [containerView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView);
    }];
    
    self.hidden = YES;
    
    [self.retryConnectionBtn addTarget:self action:@selector(retryConnectAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)triggerRetryConnectActionBlock:(void(^)(void))retryConnectionActionBlock {
    self.retryConnectionActionBlock = retryConnectionActionBlock;
}

#pragma mark - Getter Methods
- (UIImageView *)noNetworkFlowerImageView {
    if (_noNetworkFlowerImageView == nil) {
        _noNetworkFlowerImageView = [[UIImageView alloc] init];
        _noNetworkFlowerImageView.image = [UIImage imageNamed:@"common_network_loss_flower"];
    }
    return _noNetworkFlowerImageView;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
//        _tipLabel.font = kTipFont;
//        _tipLabel.textColor = kTipColor;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.preferredMaxLayoutWidth = ScreenWidth - 30;
        _tipLabel.text = @"";
    }
    return _tipLabel;
}


- (UIButton *)retryConnectionBtn {
    if (_retryConnectionBtn == nil) {
        _retryConnectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retryConnectionBtn setBackgroundColor:[UIColor dr_colorDynamicWithLight:0xffffff Dark:0x000000]];
        _retryConnectionBtn.layer.cornerRadius = kOperationBtnSize.height * 0.5;
        _retryConnectionBtn.layer.borderWidth = 1.0;
//        _retryConnectionBtn.layer.borderColor = kOperationBtnColor.CGColor;
//        _retryConnectionBtn.titleLabel.font = kOperationBtnFont;
//        [_retryConnectionBtn setTitleColor:kOperationBtnColor forState:UIControlStateNormal];
        [_retryConnectionBtn setTitle:@"" forState:UIControlStateNormal];
        _retryConnectionBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _retryConnectionBtn;
}

- (UIImage *)backSquareImage {
//    UIImage *backImage = [UIImage dr_imageWithColor:[UIColor whiteColor]
//                                               size:kOperationBtnSize
//                                       cornerRadius:(kOperationBtnSize.width * 0.5)
//                                        borderColor:kOperationBtnColor
//                                        borderWidth:1.0];
//    backImage = [backImage stretchableImageWithLeftCapWidth:(backImage.size.width * 0.5)
//                                               topCapHeight:(backImage.size.height * 0.5)];
    return [UIImage new];
}


@end
