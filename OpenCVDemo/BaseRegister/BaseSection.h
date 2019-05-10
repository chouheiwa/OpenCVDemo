//
//  BaseSection.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseAction;
NS_ASSUME_NONNULL_BEGIN

@interface BaseSection : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy, readonly) NSArray <BaseAction *>*datas;

- (void)addAction:(BaseAction *)action;

@end

NS_ASSUME_NONNULL_END
