//
//  BasePictureViewController.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasePictureViewController : UIViewController

- (void)addArrangedSubview:(UIView *)subview;

- (void)changeOriginImage:(UIImage *)image convertImage:(UIImage *)convertImage;

- (void)needChangeImage;

@end

NS_ASSUME_NONNULL_END
