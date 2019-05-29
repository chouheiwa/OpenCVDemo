//
//  CartoonControl.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/29.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "CartoonControl.h"
#import "BaseSection.h"

#import "Pic2CartoonViewController.h"

@implementation CartoonControl

+ (BaseSection *)confirmSection {
    BaseSection *section = [[BaseSection alloc] init];

    section.index = 3;

    section.title = @"卡通效果";

    section.details = @"卡通效果是将真实的图片的颜色范围变小，与加重边缘线条。";

    [section addAction:[Pic2CartoonViewController confirmAction]];

    return section;
}

@end
