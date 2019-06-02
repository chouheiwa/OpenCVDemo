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
#import "ContousFillHelper.h"

using namespace cv;
using namespace std;


@implementation ContousFillHelper

- (UIImage *)processImage:(UIImage *)image {
    Mat source;

    UIImageToMat(image, source);

    Mat dstImage = Mat::zeros(source.rows, source.cols, CV_8UC3);

    Mat gray;

    cvtColor(source, gray, CV_RGB2GRAY);

    threshold(gray, gray, 127, 255, cv::THRESH_BINARY);

    vector<vector<cv::Point>> contours;

    std::vector<cv::Vec4i> hierarchy;

    findContours(gray, contours, hierarchy, cv::RETR_CCOMP, cv::CHAIN_APPROX_SIMPLE);

    for (int index = 0; index>=0; index = hierarchy[index][0]) {
        Scalar color(rand()&255, rand()&255, rand()&255);

        drawContours(dstImage, contours, index, color,  cv::FILLED, 8, hierarchy);
    }

    return MatToUIImage(dstImage);
}


@end
