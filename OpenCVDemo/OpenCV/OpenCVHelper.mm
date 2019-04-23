//
//  OpenVCHelper.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/highgui.hpp>
#import "OpenCVHelper.h"

#import "CVAnimateStringModel.h"
#import "CVVideoModel.h"

@implementation OpenCVHelper

+ (instancetype)shareInstance {
    static OpenCVHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

+ (UIFont *)defaultFont {
    /// 这里使用了的是
    return [UIFont fontWithName:@"Courier" size:5];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(SizeT)size {
    /// cv::Mat 对象为对应的图片的二维数组对象，我们可以很方便使用角标进行数组操作
    cv::Mat cvImage;
    /// 将UIImage对象转换为对应cv::Mat对象
    UIImageToMat(image, cvImage);
    cv::Mat reSizeImage;
    /// 重新赋值大小
    cv::resize(cvImage, reSizeImage, cv::Size(size.width, size.height));
    /// 释放
    cvImage.release();
    /// 生成新的UIImage
    UIImage *nImage = MatToUIImage(reSizeImage);
    /// 释放
    reSizeImage.release();
    return nImage;
}

- (UIImage *)grayImage:(UIImage *)image {
    cv::Mat cvImage;

    UIImageToMat(image, cvImage);

    cv::Mat gray;
    // 将图像转换为灰度显示
    cv::cvtColor(cvImage, gray, CV_RGB2GRAY);

    cvImage.release();
    // 将灰度图片转成UIImage
    UIImage *nImage = MatToUIImage(gray);

    gray.release();

    return nImage;
}

- (NSString *)convertImage:(UIImage *)image {
    cv::Mat gray;

    UIImageToMat(image, gray);

    int row = gray.rows;
    int col = gray.cols;

    NSMutableArray <NSString *>* array = [NSMutableArray arrayWithCapacity:row];

    NSArray *pixels = [OpenCVHelper pixels];

    for (int i = 0 ; i < row; i ++) {
        NSMutableArray <NSString *>*item = [NSMutableArray arrayWithCapacity:col];

        for (int j = 0; j < col; j ++) {
            int temp = gray.at<uchar>(i, j);

            CGFloat percent = temp / 255.f;

            int totalCount = (pixels.count - 1) * percent;

            [item addObject:pixels[totalCount]];
        }

        [array addObject:[item componentsJoinedByString:@" "]];
    }

    gray.release();

    return [array componentsJoinedByString:@"\n"];
}

+ (NSArray <NSString *>*)pixels {
    static NSArray <NSString *>* pixels;

    if (!pixels) {
        // 这个就可耻的粘贴了别人的字符串灰度值了，一共有两组字符串灰度值，他们的表现是相反的
//        pixels = @[@" ", @".", @",", @"-", @"'", @"`", @":", @"!", @"1", @"+", @"*", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"<", @">", @"(", @")", @"\\", @"/", @"{", @"}", @"[", @"]", @"?", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"%", @"&", @"@", @"#", @"$"];
        pixels = @[@"$", @"@", @"B", @"%", @"8", @"&", @"W", @"M", @"#", @"*", @"o", @"a", @"h", @"k", @"b", @"d", @"p", @"q", @"w", @"m", @"Z", @"0", @"o", @"Q", @"L", @"C", @"J", @"U", @"Y", @"X", @"z", @"c", @"v", @"u", @"n", @"x", @"r", @"j", @"f", @"t", @"/", @"\\", @"|", @"(", @")", @"1", @"{", @"}", @"[", @"]", @"?", @"-", @"_", @"+", @"~", @"<", @">", @"i", @"!", @"l", @"I", @";", @":", @",", @"\"", @"^", @"`", @"'", @".", @" "];
    }

    return pixels;
}

- (CVAnimateStringModel *)getStringImageFromImage:(UIImage *)image withSize:(SizeT)size {
    cv::Mat cvImage;

    UIImageToMat(image, cvImage);

    CVAnimateStringModel *model = [self getStringImageFromMat:cvImage withSize:size];

    cvImage.release();

    return model;
}

- (CVAnimateStringModel *)getStringImageFromMat:(cv::Mat &)cvImage withSize:(SizeT)size {
    if (!cvImage.empty()) {
        cv::Mat reSizeImage;
        cv::resize(cvImage, reSizeImage, cv::Size(size.width, size.height));

        CVAnimateStringModel *model = [CVAnimateStringModel new];

        NSArray *pixels = [OpenCVHelper pixels];
        cv::Mat gray;
        // 将图像转换为灰度显示
        cv::cvtColor(reSizeImage,gray,CV_RGB2GRAY);
        // 将灰度图片转成UIImage
        model.image = MatToUIImage(gray);

        int row = gray.rows;
        int col = gray.cols;

        NSMutableArray <NSString *>* array = [NSMutableArray arrayWithCapacity:row];

        for (int i = 0 ; i < row; i ++) {
            NSMutableArray <NSString *>*item = [NSMutableArray arrayWithCapacity:col];

            for (int j = 0; j < col; j ++) {
                int temp = gray.at<uchar>(i, j);
                // 获取灰度百分比
                CGFloat percent = temp / 255.f;
                // 根据百分比，获取对应字符串下标
                int totalCount = (pixels.count - 1) * percent;
                // 
                [item addObject:pixels[totalCount]];
            }
            // 这里最早是没有空格的
            [array addObject:[item componentsJoinedByString:@" "]];
        }

        gray.release();

        model.animateString = [array componentsJoinedByString:@"\n"];
        return model;
    }

    return nil;
}

- (void)processVideo:(NSString *)videoPath withSize:(SizeT)size processBlock:(void(^)(CVAnimateStringModel *))processBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        cv::VideoCapture cap;
        cap.open(videoPath.UTF8String);

        if (cap.isOpened()) {
            NSTimeInterval time = [OpenCVHelper videoFrameDurationFromVideoPath:videoPath];

            cv::Mat frame;
            while (1) {
                cap>>frame;

                if (frame.empty()) {
                    break;
                }

                processBlock([self getStringImageFromMat:frame withSize:size]);
                [NSThread sleepForTimeInterval:time];
            }
        }

        cap.release();
   });
}

- (CVVideoModel *)processVideo:(NSString *)videoPath withSize:(SizeT)size processPercent:(nullable ProcessBlock)process {
    cv::VideoCapture cap;
    cap.open(videoPath.UTF8String);

    CVVideoModel *model;

    if (cap.isOpened()) {
        model = [[CVVideoModel alloc] init];
        /// 获取视频总帧数(用以计算百分比)
        NSInteger totalFrameCount = [OpenCVHelper getVideoFramesCountByVideoPath:videoPath];
        /// 获取视频播放间隔(为了接下来播放字符串动画做准备)
        NSTimeInterval timeDuration = [OpenCVHelper videoFrameDurationFromVideoPath:videoPath];

        model.frameDuration = timeDuration;

        NSMutableArray *array = [NSMutableArray arrayWithCapacity:20000];

        cv::Mat frame;
        while (1) {
            cap>>frame;

            if (frame.empty()) {
                break;
            }

            [array addObject:[self getStringImageFromMat:frame withSize:size]];

            if (process) {
                dispatch_async(dispatch_get_main_queue(), ^{

                    process(array.count * 1.f / totalFrameCount);
                });
            }
        }

        model.animatedList = array;
    }

    cap.release();

    return model;
}

+ (CGFloat)nominalFrameRateFromVideoPath:(NSString *)videoPath {
    CGFloat fps = 0.00;
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        return fps;
    }
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    fps = videoTrack.nominalFrameRate;

    return fps;
}

+ (NSTimeInterval)videoFrameDurationFromVideoPath:(NSString *)videoPath {
    return 1.f / [self nominalFrameRateFromVideoPath:videoPath];
}

+ (NSTimeInterval)videoDurationFromVideoPath:(NSString *)videoPath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        return 0.00;
    }
    NSDictionary *inputOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:inputOptions];
    return 1000.0 * urlAsset.duration.value / urlAsset.duration.timescale;
}

+ (NSInteger)getVideoFramesCountByVideoPath:(NSString*)videoPath {
    double fps = 0;

    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        return fps;
    }
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    fps = videoTrack.nominalFrameRate;

    CMTime time = asset.duration;
    double seconds = time.value/time.timescale;

    /// 这个情况下总帧数计算不是很准，但是大致不会相差太远，我们展示处理进度只是暂时性的
    return seconds * fps;
}


@end
