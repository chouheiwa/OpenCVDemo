//
//  AnimatedFlowViewController.h
//  OpenCVDemo
//
//  Created by Di on 2019/4/22.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseActionProtocol.h"
typedef NS_ENUM(NSUInteger, FlowStep) {
    FlowStepFirst = 0, // 显示原图
    FlowStepSecond, // 将原图压缩成指定大小缩略图
    FlowStepThird, // 将缩略图转成对应的灰度图
};

NS_ASSUME_NONNULL_BEGIN

@interface StringFlowViewController : UIViewController <BaseActionProtocol>

@property (nonatomic, assign) FlowStep step;
// 上一步展示的图片
@property (nonatomic, strong) UIImage *showImage;
// 最初图片
@property (nonatomic, strong) UIImage *firstStepImage;

@end

NS_ASSUME_NONNULL_END
