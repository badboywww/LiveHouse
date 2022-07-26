//
//  myNavigationBar.m
//  basicFramework
//
//  Created by Bad on 2019/2/27.
//  Copyright © 2019 studentW. All rights reserved.
//

#import "myNavigationBar.h"

#import "backView.h"

@interface myNavigationBar()

/** isSub */
@property (nonatomic , assign) BOOL * isSub;

@end

@implementation myNavigationBar

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[backView class]]) {
            v.left = 0;
        }
    }
}

@end
