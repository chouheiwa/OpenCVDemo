//
//  HandPaintSliderView.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSliderView : UIStackView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat minValue;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) short precision;

@property (nonatomic, copy) void (^valueChangeBlock) (CGFloat value);

@end

NS_ASSUME_NONNULL_END
