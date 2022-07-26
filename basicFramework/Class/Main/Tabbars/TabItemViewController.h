//
//  TabItemViewController.h
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabItemViewController : UIViewController

@property (nonatomic, readonly, nullable) NSString *viewtimeFBEventName;
@property (nonatomic, assign) BOOL selected;

- (BOOL)overrideTabbarCameraAction;

@end

NS_ASSUME_NONNULL_END
