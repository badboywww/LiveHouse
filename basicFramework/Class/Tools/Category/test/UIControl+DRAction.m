//
//  UIControl+DRAction.m
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import "UIControl+DRAction.h"
#import <ProjectCommon/NSObject+DRExtraData.h>
@class GLControlActionElement;
@implementation UIControl (DRAction)

#pragma mark - Public Method
- (void)dr_controlTapAction:(DRControlActionBlock)action {
    self.dr_tapControlActionElement.action = action;
}

- (void)dr_controlTapWithTarget:(id)target selector:(SEL)selector {
    self.dr_tapControlActionElement.action = nil;
    self.dr_tapControlActionElement.actionTarget = target;
    self.dr_tapControlActionElement.actionSelector = selector;
}

#pragma mark - Setter Getter
- (void)setDr_tapControlActionElement:(DRControlActionElement *)dr_tapControlActionElement {
    [self dr_extraDataForSelector:@selector(dr_tapControlActionElement)].data = dr_tapControlActionElement;
}

- (DRControlActionElement *)dr_tapControlActionElement {
    DRControlActionElement *element = [self dr_extraDataForSelector:@selector(dr_tapControlActionElement)].data;
    if (!element) {
        element = [DRControlActionElement new];
        element.target = self;
        self.dr_tapControlActionElement = element;
    }
    
    return element;
}

@end


@implementation DRControlActionElement

#pragma mark - Actions
- (void)targetDidTouchUpInside:(UIControl *)sender {
    if (self.action) {
        self.action(self.target);
    }
    else if (self.actionTarget && self.actionSelector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.actionTarget performSelector:self.actionSelector withObject:self.target];
#pragma clang diagnostic pop
    }
}

#pragma mark - Setter Getter
- (void)setTarget:(UIControl *)target {
    if (_target == target) {
        return;
    }
    
    [_target removeTarget:self action:@selector(targetDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    _target = target;
    [_target addTarget:self action:@selector(targetDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

@end
