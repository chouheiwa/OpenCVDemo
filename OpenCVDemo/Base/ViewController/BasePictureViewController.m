//
//  BasePictureViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BasePictureViewController.h"

@interface BasePictureViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *baseStackView;
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *convertImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCostraint;

@end

@implementation BasePictureViewController

- (instancetype)init {
    self = [super initWithNibName:@"BasePictureViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.originImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(needChangeImage)]];
}

- (void)needChangeImage {
    
}

- (void)addArrangedSubview:(UIView *)subview {
    [self.baseStackView addArrangedSubview:subview];
}

- (void)resizeImageView {
    UIImage *image = self.originImageView.image;

    CGSize size = image.size;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGFloat height = width / size.width * size.height;

    self.heightCostraint.constant = height;
}

- (void)changeOriginImage:(UIImage *)image convertImage:(UIImage *)convertImage {
    self.originImageView.image = image;

    self.convertImageView.image = convertImage;

    [self resizeImageView];
}

@end
