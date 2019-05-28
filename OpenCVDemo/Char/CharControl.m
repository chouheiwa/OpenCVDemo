//
//  CharControl.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/27.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "CharControl.h"
#import "BaseSection.h"

#import "StringFlowViewController.h"
#import "Video2CharViewController.h"
#import "Camera2CharViewController.h"
@implementation CharControl

+ (BaseSection *)confirmSection {
    BaseSection *section = [[BaseSection alloc] init];

    section.index = 0;

    section.title = @"字符画";

    section.details = @"";

    [section addAction:[StringFlowViewController confirmAction]];

    [section addAction:[Video2CharViewController confirmAction]];

    [section addAction:[Camera2CharViewController confirmAction]];

    return section;
}

@end
