//
//  DebuggerControlModel.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebuggerControlModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat minValue;

@property (nonatomic, assign) short precision;

@end

NS_ASSUME_NONNULL_END
