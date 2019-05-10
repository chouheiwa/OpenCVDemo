//
//  BaseRegister.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 这个类的出现是因为之前所有的基础页面显示与跳转全部是在BasicViewController中操作的

 随着现有教程越来越多，每次都修改Controller的感觉并不好，同时跳转逻辑均在Controller中，体验也不好。所以修改
 */
@interface BaseRegister : NSObject

+ (void)start;


@end

NS_ASSUME_NONNULL_END
