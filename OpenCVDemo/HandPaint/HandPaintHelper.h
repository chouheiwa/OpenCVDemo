//
//  HandPaintHelper.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HandPaintHelper : NSObject

- (UIImage *)processImage:(UIImage *)image depth:(double)depth;

@end

NS_ASSUME_NONNULL_END
