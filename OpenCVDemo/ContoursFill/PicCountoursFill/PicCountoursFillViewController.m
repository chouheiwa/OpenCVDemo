//
//  PicCountoursFillViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "PicCountoursFillViewController.h"
#import "BaseAction.h"

@interface PicCountoursFillViewController ()

@end

@implementation PicCountoursFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

+ (BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.index = 0;

    action.title = @"轮廓标注";

    action.detail = @"提取轮廓并标注到图片上";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
