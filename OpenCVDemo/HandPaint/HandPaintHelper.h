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


/**
 将图片转换成手绘图，目前对于场景比较大的风景画效果比较好

 @param image 原始图片
 @param depth 设定的景深
 @param elevation 光线仰角
 @param azimuth 光线倾斜角
 @return 处理过的手绘图片
 */
- (UIImage *)processImage:(UIImage *)image depth:(double)depth elevation:(double)elevation azimuth:(double)azimuth;

@end

NS_ASSUME_NONNULL_END
