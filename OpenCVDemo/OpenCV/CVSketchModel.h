//
//  CVSketchModel.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/14.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSketchModel : NSObject

@property (nonatomic, strong) NSArray <UIImage *>* animatedList;

@property (nonatomic, assign) NSTimeInterval frameDuration;

@end

NS_ASSUME_NONNULL_END
