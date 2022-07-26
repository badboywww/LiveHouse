//
//  UIControl+DRAction.h
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DRControlActionElement;

typedef void(^DRControlActionBlock)(__kindof UIControl *control);

@interface UIControl (GLAction)

@property (nonatomic, strong) DRControlActionElement *gl_tapControlActionElement;   /// store the Action attribute element

/// Performs an action when UIControl(UIButton etc.) is clicked
/// @Param action Block
- (void)dr_controlTapAction:(DRControlActionBlock)action;


/// Performs an action when UIControl(UIButton etc.) is clicked
/// @Param target target view
/// @Param selector action
- (void)dr_controlTapWithTarget:(id)target selector:(SEL)selector;

@end


@interface DRControlActionElement : NSObject

@property (nonatomic, weak) UIControl *target;  /// Binding View
@property (nonatomic, copy, nullable) DRControlActionBlock action;
@property (nonatomic, weak) id actionTarget;
@property (nonatomic, assign) SEL actionSelector;

@end

NS_ASSUME_NONNULL_END
