//
//  ConntousFillHelper.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/highgui.hpp>
#import "LogoGenerateHelper.h"

using namespace cv;
using namespace std;


@implementation LogoGenerateHelper

- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;

    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)

    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    cvMat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedLast |
                                                    kCGBitmapByteOrderDefault);

    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);

    return cvMat;
}

- (UIImage *)processImage:(UIImage *)image {
    Mat source = [self cvMatFromUIImage:image];

    Mat dstImage = source.clone();

//    return MatToUIImage(dstImage);

    Mat gray;

    cvtColor(source, gray, CV_RGB2GRAY);

    threshold(gray, gray, 220, 255, cv::THRESH_BINARY);

    vector<vector<cv::Point>> contours;

    std::vector<cv::Vec4i> hierarchy;

    findContours(gray, contours, hierarchy, cv::RETR_CCOMP, cv::CHAIN_APPROX_SIMPLE);

    NSArray *colors = @[
                       [UIColor redColor],
                       [UIColor greenColor],
                       [UIColor blueColor],
                       ];

    int current = 0;

    for (int index = 0; index >= 0; index = hierarchy[index][0]) {
        UIColor *aColor = colors[current%colors.count];

        current ++;

        CGFloat red, green, blue, alpha;

        [aColor getRed:&red green:&green blue:&blue alpha:&alpha];

        Scalar color(red * 255, green * 255, blue * 255, 255);

        drawContours(dstImage, contours, index, color,  cv::FILLED, 8, hierarchy);
    }

    return MatToUIImage(dstImage);
}


@end
