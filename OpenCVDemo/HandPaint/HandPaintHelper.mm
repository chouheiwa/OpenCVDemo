//
//  HandPaintHelper.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/highgui.hpp>
#import "HandPaintHelper.h"
using namespace cv;
using namespace std;

@interface HandPaintHelper ()

{
    Mat _depthX;
    Mat _depthY;
    Mat _depthZ;
}

@property (nonatomic, assign) double depth;

@property (nonatomic, strong) UIImage *originImage;

@end

@implementation HandPaintHelper

- (void)dealloc {
    _depthX.release();
    _depthY.release();
    _depthZ.release();
}

- (UIImage *)processImage:(UIImage *)image depth:(double)depth elevation:(double)elevation azimuth:(double)azimuth {

    do {
        // double 可能存在误差
        if (_originImage == image && (fabs(_depth - depth) < 0.000001)) break;

        _originImage = image;

        _depth = depth;

        Mat mat;

        UIImageToMat(image, mat);
        // 转灰度图
        cvtColor(mat,mat,CV_RGB2GRAY);

        Mat gradientX;
        Mat gradientY;

        Sobel(mat, gradientX, CV_64F, 1, 0, 3);

        Sobel(mat, gradientY, CV_64F, 0, 1, 3);

        gradientX = gradientX * (depth / 100.f);
        gradientY = gradientY * (depth / 100.f);

        Mat result;

        sqrt(gradientX.mul(gradientX) + gradientY.mul(gradientY) + 1.f, result);

        _depthX = gradientX / result;
        _depthY  = gradientY / result;
        _depthZ = 1.f / result;

        mat.release();
        result.release();
        gradientX.release();
        gradientY.release();
    } while (NO);



    double el = M_PI * elevation;
    double az = M_PI * azimuth;

    double x = cos(el) * cos(az);
    double y = cos(el) * sin(az);
    double z = sin(el);

    Mat result = 255 * (x * _depthX + y * _depthY + z * _depthZ);

    result.convertTo(result, CV_8U);

    UIImage *resultImage = MatToUIImage(result);

    result.release();

    return resultImage;
}

@end
