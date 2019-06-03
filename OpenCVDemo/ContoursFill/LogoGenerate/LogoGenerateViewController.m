//
//  PicCountoursFillViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "LogoGenerateViewController.h"
#import "BaseAction.h"


#import "LogoGenerateHelper.h"

@interface LogoGenerateViewController ()

@end

@implementation LogoGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    LogoGenerateHelper *helper = [[LogoGenerateHelper alloc] init];

    UIImage *image = [UIImage imageNamed:@"opencv_logo.png"];

    [self changeOriginImage:image convertImage:[helper processImage:image]];
}

+ (BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.index = 0;

    action.title = @"Logo处理";

    action.detail = @"这个选项的用途是生成本demo中的logo";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
