//
//  OpenVCHelper.h
//  OpenCVDemo
//
//  Created by Di on 2019/4/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct{
    int width, height;
}SizeT;

@class CVAnimateStringModel;
@class CVVideoModel;
@class CVSketchModel;

namespace cv {
    class Mat;
}

typedef void(^ProcessBlock)(CGFloat percent);

@interface OpenCVHelper : NSObject

+ (instancetype)shareInstance;

+ (UIFont *)defaultFont;
// 转换图片大小
- (UIImage *)resizeImage:(UIImage *)image withSize:(SizeT)size;
// 将给定图片转换为灰度图
- (UIImage *)grayImage:(UIImage *)image;
// 将给定灰度图转换为字符串
- (NSString *)convertImage:(UIImage *)image;
// 从普通图片中获得字符串
- (NSArray <NSString *>*)getStringImageFromImage:(UIImage *)image withSize:(SizeT)size;

- (CVAnimateStringModel *)getStringImageFromMat:(cv::Mat &)cvImage withSize:(SizeT)size;

- (void)processVideo:(NSString *)videoPath withSize:(SizeT)size processBlock:(void(^)(CVAnimateStringModel *model))processBlock;

- (CVVideoModel *)processVideo:(NSString *)videoPath withSize:(SizeT)size processPercent:(nullable ProcessBlock)process;

#pragma mark ---这个是素描画的相关函数---
// 将给定图片进行高斯模糊
- (UIImage *)gaussianblurImage:(UIImage *)image;
// 将给定图片进行自适应二值化
- (UIImage *)adaptiveThresholdImage:(UIImage *)image;
// 给定图片进行普通二值化
- (UIImage *)thresholdImage:(UIImage *)image;
// 给定图片进行开运算
- (UIImage *)morphologyImage:(UIImage *)image;
// 通过cvMat直接获取图片
- (UIImage *)getSketchImage:(cv::Mat)image;

- (CVSketchModel *)processSketchVideo:(NSString *)videoPath processPercent:(nullable ProcessBlock)process;

@end

NS_ASSUME_NONNULL_END
