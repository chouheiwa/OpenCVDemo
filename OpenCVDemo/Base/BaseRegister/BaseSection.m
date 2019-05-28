//
//  BaseSection.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BaseSection.h"
#import "BaseAction.h"
@interface BaseSection ()

@property (nonatomic, strong) NSMutableArray <BaseAction *>*detail;

@end

@implementation BaseSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.detail = [NSMutableArray arrayWithCapacity:20];
    }
    return self;
}

- (NSArray<BaseAction *> *)datas {
    return [_detail copy];
}

/**
 因为我们的插入属于向有序数据插入，因此这里选择二分法

 @param action 操作对象
 */
- (void)addAction:(BaseAction *)action {
    if (_detail.count == 0) {
        [_detail addObject:action];
        return;
    }

    NSInteger start = 0;
    NSInteger end = _detail.count - 1;

    if (_detail[start].index >= action.index) {
        [_detail insertObject:action atIndex:start];
        return;
    }

    if (_detail[end].index <= action.index) {
        [_detail addObject:action];
        return;
    }

    while (start < end) {
        NSInteger current = (start + end) / 2;

        if (_detail[current].index < action.index) {
            end = current;
        } else {
            start = current;
        }
    }

    if (_detail[start].index > action.index) {
        [_detail insertObject:action atIndex:start];
    } else {
        [_detail insertObject:action atIndex:start + 1];
    }
}

@end
