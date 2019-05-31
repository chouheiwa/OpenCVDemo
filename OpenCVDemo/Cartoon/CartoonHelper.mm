//
//  Pic2CartoonHelper.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/29.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/highgui.hpp>
#import "CartoonHelper.h"

using namespace cv;
using namespace std;

@implementation CartoonHelper

- (UIImage *)processCVImage:(Mat)source {
    cvtColor(source, source, COLOR_BGRA2BGR);

    /** EDgES **/
    // Apply median filter to remove possible noise
    Mat sourceMedian;
    medianBlur(source, sourceMedian, 7);

    // Detect edges with canny
    Mat sourceCanny;
    Canny(source, sourceCanny, 50, 150);

    // Dilate the edges
    Mat kernel = getStructuringElement(MORPH_RECT, cv::Size(2, 2));
    dilate(sourceCanny, sourceCanny, kernel);

    // Scale edges values to 1 and invert values
    sourceCanny = sourceCanny / 255;
    sourceCanny = 1 - sourceCanny;
    // Use float values to allow multiply between 0 and 1
    Mat sourceCannyf;
    sourceCanny.convertTo(sourceCannyf, CV_32FC3);
    // Blur the edgest to do smooth effect
    blur(sourceCannyf, sourceCannyf, cv::Size(5, 5));

    Mat sourceBF;
    bilateralFilter(source, sourceBF, 5, 220.0, 220.0);
    // truncate colors
    Mat result = sourceBF / 25;
    result = result * 25;
    /** MERgES COLOR + EDgES **/
    // Create a 3 channles for edges
    Mat sourceCanny3c;
    Mat cannyChannels[] = { sourceCannyf, sourceCannyf, sourceCannyf };
    merge(cannyChannels, 3, sourceCanny3c);
    // Convert color result to float
    Mat resultf;
    result.convertTo(resultf, CV_32FC3);
    // Multiply color and edges matrices
    //    cout << sourceCanny3c << endl;
    multiply(resultf, sourceCanny3c, resultf);
    //    cout << resultf << endl;
    // convert to 8 bits color
    resultf.convertTo(result, CV_8UC3);

    UIImage *resultImage = MatToUIImage(result);

    return resultImage;
}

- (UIImage *)processImage:(UIImage *)image {
    Mat source;

    UIImageToMat(image, source);

    return [self processCVImage:source];
}

@end
