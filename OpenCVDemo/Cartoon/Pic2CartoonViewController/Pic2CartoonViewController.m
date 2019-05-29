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
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *convertImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstant;

@end

@implementation Pic2CartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"卡通画";

    [self changeOriginImage:[UIImage imageNamed:@"handPaint.jpg"]];
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

- (void)resizeImageView {
    UIImage *image = self.originImageView.image;

    CGSize size = image.size;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGFloat height = width / size.width * size.height;

    self.heightConstant.constant = height;
}

- (void)changeOriginImage:(UIImage *)image {
    self.originImageView.image = image;

    CartoonHelper *helper = [[CartoonHelper alloc] init];

    self.convertImageView.image = [helper processImage:image];

    [self resizeImageView];
}

@end
