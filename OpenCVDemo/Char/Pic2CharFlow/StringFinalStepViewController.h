//
//  AnimatedFinalStepViewController.h
//  OpenCVDemo
//
//  Created by Di on 2019/4/22.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CVAnimateStringModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StringFinalStepViewController : UIViewController

@property (nonatomic, strong) CVAnimateStringModel *model;

@property (nonatomic, strong) UIImage *firstStepImage;

@end

NS_ASSUME_NONNULL_END
