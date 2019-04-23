//
//  CVVideoModel.h
//  OpenCVDemo
//
//  Created by Di on 2019/4/16.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVAnimateStringModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVVideoModel : NSObject

@property (nonatomic, copy) NSArray <CVAnimateStringModel *>* animatedList;

@property (nonatomic, assign) NSTimeInterval frameDuration;

@end

NS_ASSUME_NONNULL_END
