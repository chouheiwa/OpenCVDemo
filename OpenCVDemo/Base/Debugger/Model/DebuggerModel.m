//
//  DebuggerModel.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "DebuggerModel.h"
#import "DebuggerControlModel.h"

@interface DebuggerModel ()

@property (nonatomic, strong) NSMutableArray <DebuggerControlModel *>*controlArray;

@end

@implementation DebuggerModel

- (void)addControlTitle:(NSString *)title value:(CGFloat)value maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue precision:(short)precision {
    DebuggerControlModel *model = [[DebuggerControlModel alloc] initWithTitle:title value:value maxValue:maxValue minValue:minValue precision:precision];

    [self.controlArray addObject:model];
}

@end
