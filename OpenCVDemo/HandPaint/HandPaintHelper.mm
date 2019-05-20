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
@implementation HandPaintHelper

- (UIImage *)processImage:(UIImage *)image {
    Mat mat;

    UIImageToMat(image, mat);

    cvtColor(mat,mat,CV_RGB2GRAY);

    Mat Dx;
    Sobel(mat, Dx, CV_64F, 1, 0, 3);

    Mat Dy;
    Sobel(mat, Dy, CV_64F, 0, 1, 3);

    double depth = 2.f;

    Dx = Dx * (depth / 100.f);
    Dy = Dy * (depth / 100.f);

    Mat dx = Dx.mul(Dx);
    Mat dy = Dy.mul(Dy);

    Mat result;

    sqrt(dx + dy + 1.f, result);

    dx = Dx / result;
    dy = Dy / result;
    Mat dz = 1.f / result;

    result *= 255;

//    cout<<result<<endl;

    double el = M_PI / 2.2;
    double az = M_PI / 4;

    double x = cos(el) * cos(az);
    double y = cos(el) * sin(az);
    double z = sin(el);

    result = 255 * (x * dx + y * dy + z * dz);

    result.convertTo(result, CV_8U);

//    cout<<result<<endl;

    UIImage *resultImage = MatToUIImage(result);

    result.release();

    return resultImage;
}

@end
