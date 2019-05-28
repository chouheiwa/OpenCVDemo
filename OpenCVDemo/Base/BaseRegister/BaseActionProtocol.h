//
//  BaseActionProtocol.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BaseAction;

@protocol BaseActionProtocol <NSObject>

+ (BaseAction *)confirmAction;

@end

NS_ASSUME_NONNULL_END
