//
//  MediaDispose.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/15.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MediaDispose;

@protocol MediaDisposeDelegate <NSObject>

- (void)mediaDispose:(MediaDispose *)mediaDispose didSuccessWithPath:(NSString *)path;

- (void)mediaDispose:(MediaDispose *)mediaDispose changeProgress:(CGFloat)process;

- (void)mediaDispose:(MediaDispose *)mediaDispose didFailed:(NSError *)error;

@end
#pragma mark - 将连串的图片生成视频，并将视频输出至指定目录
@interface MediaDispose : NSObject

@property (nonatomic, copy) NSString *outputPath;

@property (nonatomic, assign) NSTimeInterval frameDuration;

@property (nonatomic, assign) CGSize size;

@end

NS_ASSUME_NONNULL_END
