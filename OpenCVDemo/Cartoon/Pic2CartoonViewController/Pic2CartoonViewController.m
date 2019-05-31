//
//  Pic2CartoonViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/29.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2CartoonViewController.h"
#import "BaseAction.h"

#import "CartoonHelper.h"

@interface Pic2CartoonViewController ()

@end

@implementation Pic2CartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"卡通画";

    CartoonHelper *helper = [[CartoonHelper alloc] init];

    UIImage *image = [UIImage imageNamed:@"handPaint.jpg"];

    [self changeOriginImage:[UIImage imageNamed:@"handPaint.jpg"] convertImage:[helper processImage:image]];
}

+ (BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.index = 0;

    action.title = @"图像卡通化";

    action.detail = @"";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
