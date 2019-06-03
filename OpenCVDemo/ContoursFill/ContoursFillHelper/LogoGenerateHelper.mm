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

- (UIImage *)processImage:(UIImage *)image {
    Mat source;

    UIImageToMat(image, source);

    Mat dstImage = source.clone();

    Mat gray;

    cvtColor(source, gray, CV_RGB2GRAY);

    threshold(gray, gray, 220, 255, cv::THRESH_BINARY);

    vector<vector<cv::Point>> contours;

    std::vector<cv::Vec4i> hierarchy;

    findContours(gray, contours, hierarchy, cv::RETR_CCOMP, cv::CHAIN_APPROX_SIMPLE);

    NSArray *colors = @[
                       [UIColor redColor],
                       [UIColor yellowColor],
                       [UIColor blueColor],
                       [UIColor lightGrayColor],
                       [UIColor orangeColor],
                       [UIColor cyanColor],
                       [UIColor brownColor]
                       ];

    int current = 0;

    for (int index = 0; index>=0; index = hierarchy[index][0]) {
        UIColor *aColor = colors[current%colors.count];

        current ++;

        CGFloat red, green, blue, alpha;

        [aColor getRed:&red green:&green blue:&blue alpha:&alpha];

        Scalar color(red * 255, green * 255, blue * 255, 255);

        drawContours(dstImage, contours, index, color,  cv::FILLED, 8, hierarchy);
    }

//    multiply(dstImage, source, dstImage);

    return MatToUIImage(dstImage);
}


@end
