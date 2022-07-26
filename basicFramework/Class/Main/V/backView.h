//
//  backView.h
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface backView : UIView

+ (instancetype)backViewWithImageName:(UIImage *)image highImageName:(UIImage *)highimage Target:(nullable id)target Action:(nullable SEL)action Title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
