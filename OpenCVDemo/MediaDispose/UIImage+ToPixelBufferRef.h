//
//  UIImage+toPixelBufferRef.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/15.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ToPixelBufferRef)

- (CVPixelBufferRef)pixelBufferRefWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
