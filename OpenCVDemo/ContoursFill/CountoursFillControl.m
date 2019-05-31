//
//  CountoursFillControl.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "CountoursFillControl.h"
#import "BaseSection.h"

@implementation CountoursFillControl

+ (BaseSection *)confirmSection {
    BaseSection *section = [[BaseSection alloc] init];

    section.index = 4;

    section.title = @"轮廓提取";

    section.details = @"暂时用于测试轮廓提取相关功能";

    

    return section;
}

@end
