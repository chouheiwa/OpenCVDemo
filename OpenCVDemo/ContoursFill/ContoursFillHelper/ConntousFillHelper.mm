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
#import "ConntousFillHelper.h"

using namespace cv;
using namespace std;


@implementation ConntousFillHelper

- (UIImage *)processImage:(UIImage *)image {
    Mat source;

    UIImageToMat(image, source);

    Mat gray;

    cvtColor(source, gray, CV_RGB2GRAY);
}


@end
