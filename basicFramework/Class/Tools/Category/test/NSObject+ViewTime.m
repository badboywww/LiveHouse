//
//  NSObject+ViewTime.m
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import "NSObject+ViewTime.h"

#import <objc/runtime.h>

static void *kViewTimeAssociatedKey = &kViewTimeAssociatedKey;

@implementation NSObject (ViewTime)
@dynamic beginTime;

- (void)setBeginTime:(NSInteger)beginTime {
    objc_setAssociatedObject(self, kViewTimeAssociatedKey, @(beginTime), OBJC_ASSOCIATION_COPY);
}

- (NSInteger)beginTime {
    NSNumber *time = objc_getAssociatedObject(self, kViewTimeAssociatedKey);
    NSInteger beginTime=  [time integerValue];
    return beginTime;
}

- (NSInteger)currentTime {
    NSInteger time = (NSInteger)CFAbsoluteTimeGetCurrent();
    return time;
}

- (void)beginRecordViewTime {
    self.beginTime = [self currentTime];
}

- (NSInteger)endRecordViewTime {
    NSInteger time = [self currentTime];
    NSInteger viewTime = time - self.beginTime;
    return viewTime;
}

@end
