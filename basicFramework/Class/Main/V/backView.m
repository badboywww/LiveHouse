//
//  backView.m
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import "backView.h"

@implementation backView

+ (instancetype)backViewWithImageName:(UIImage *)image highImageName:(UIImage *)highimage Target:(nullable id)target Action:(nullable SEL)action Title:(NSString *)title{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highimage forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    
    
    backView *view = [[self alloc]initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    
    return view;
    
}

@end
