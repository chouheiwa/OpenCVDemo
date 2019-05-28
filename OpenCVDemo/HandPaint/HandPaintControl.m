//
//  HandPaintControl.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/27.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "HandPaintControl.h"
#import "BaseSection.h"

#import "Pic2HandPrintViewController.h"

@implementation HandPaintControl

+ (BaseSection *)confirmSection {
    BaseSection *section = [[BaseSection alloc] init];

    section.title = @"手绘画";

    section.details = @"";

    section.index = 2;

    [section addAction:[Pic2HandPrintViewController confirmAction]];

    return section;
}

@end
