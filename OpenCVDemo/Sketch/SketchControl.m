//
//  SketchControl.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/27.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "SketchControl.h"
#import "BaseSection.h"
#import "Video2SketchViewController.h"
#import "Camera2SketchViewController.h"
#import "Pic2SketchViewController.h"

@implementation SketchControl

+ (BaseSection *)confirmSection {
    BaseSection *section = [[BaseSection alloc] init];

    section.title = @"素描画";

    section.details = @"线条画勾勒边框，应该称之为边框画更好";

    section.index = 1;

    [section addAction:[Video2SketchViewController confirmAction]];

    [section addAction:[Camera2SketchViewController confirmAction]];

    [section addAction:[Pic2SketchViewController confirmAction]];

    return section;
}

@end
