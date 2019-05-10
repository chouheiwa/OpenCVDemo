//
//  Pic2SketchModel.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2SketchModel.h"
#import "OpenCVHelper.h"

@interface Pic2SketchModel ()

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) NSArray *contentsArray;

@end

@implementation Pic2SketchModel

- (instancetype)init {
    if (self = [super init]) {
        OpenCVHelper *helper = [OpenCVHelper shareInstance];
        // 原图
        UIImage *firstImage = [UIImage imageNamed:@"cxk.jpg"];
        // 灰度图
        UIImage *grayImage = [helper grayImage:firstImage];
        // 高斯模糊
        UIImage *blurImage = [helper gaussianblurImage:grayImage];
        // 自适应二值化
        UIImage *adaImage = [helper adaptiveThresholdImage:blurImage];
        // 再次高斯模糊
        UIImage *blurAgainImage = [helper gaussianblurImage:adaImage];
        // 普通二值化
        UIImage *threImage = [helper thresholdImage:blurAgainImage];
        // 开运算
        UIImage *morImage = [helper morphologyImage:threImage];
        // 第三次高斯模糊
        UIImage *blurFinalImage = [helper gaussianblurImage:morImage];

        self.imagesArray = @[firstImage, grayImage, blurImage, adaImage, blurAgainImage, threImage, morImage, blurFinalImage];

        self.contentsArray = @[@"展示原图",
                               @"转变为灰度图",
                               @"进行第一次高斯模糊(模糊背景)",
                               @"进行一次自适应二值化，这个时候整个素描画的轮廓已经出现了。但是我们仔细观察会发现，线条不够粗，显得有些细了，图片上还有一些黑点",
                               @"再次高斯模糊(虚化背景)",
                               @"进行普通二值化(加粗线条)",
                               @"进行开运算(去除噪点)",
                               @"最后进行一次高斯模糊"];

    }
    return self;
}

- (NSArray *)getObjectsFromBlock:(id(^)(UIImage *image, NSString *content, NSInteger index))block {
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < self.imagesArray.count; i ++) {
        [array addObject:block(self.imagesArray[i], self.contentsArray[i], i)];
    }

    return [array copy];
}

@end
