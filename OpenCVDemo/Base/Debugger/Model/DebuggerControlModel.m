//
//  DebuggerControlModel.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "DebuggerControlModel.h"

@implementation DebuggerControlModel

- (instancetype)initWithTitle:(NSString *)title value:(CGFloat)value maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue precision:(short)precision {
    if (self = [super init]) {
        _title = title;

        _value = value;

        _maxValue = maxValue;

        _minValue = minValue;

        _precision = precision;
    }

    return self;
}

@end
