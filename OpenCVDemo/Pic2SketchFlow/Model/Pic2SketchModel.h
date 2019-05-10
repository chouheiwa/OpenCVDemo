//
//  Pic2SketchModel.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pic2SketchModel : NSObject

- (NSArray *)getObjectsFromBlock:(id(^)(UIImage *image, NSString *content, NSInteger index))block;

@end

NS_ASSUME_NONNULL_END
