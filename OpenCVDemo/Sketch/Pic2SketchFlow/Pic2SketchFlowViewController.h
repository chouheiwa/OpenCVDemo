//
//  Pic2SketchFlowViewController.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pic2SketchViewControllerProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Pic2SketchFlowViewController : UIViewController <Pic2SketchViewControllerProtocol>

@property (nonatomic, strong) UIImage *showImage;

@property (nonatomic, copy) NSString *showContent;


@end

NS_ASSUME_NONNULL_END
