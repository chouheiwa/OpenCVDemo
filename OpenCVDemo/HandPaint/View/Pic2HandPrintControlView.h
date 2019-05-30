//
//  Pic2HandPrintControlView.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pic2HandPrintControlView : UIView

@property (nonatomic, assign) CGFloat depth;

@property (nonatomic, assign) CGFloat elevation;

@property (nonatomic, assign) CGFloat azimuth;

- (void)valueDidChange:(void(^)(CGFloat depth,CGFloat elevation,CGFloat azimuth))changeBlock;

+ (Pic2HandPrintControlView *)createFromXib;

@end

NS_ASSUME_NONNULL_END
