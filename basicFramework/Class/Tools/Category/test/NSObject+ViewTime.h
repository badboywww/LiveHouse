//
//  NSObject+ViewTime.h
//  basicFramework
//
//  Created by DevWang on 2022/7/22.
//  Copyright © 2022 Dream works. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ViewTime)

@property (nonatomic, assign) NSInteger beginTime;

- (void)beginRecordViewTime;
- (NSInteger)endRecordViewTime;

@end

NS_ASSUME_NONNULL_END
