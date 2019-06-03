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

    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImage)];

    gesture.minimumPressDuration = 2;

    [self.convertImageView addGestureRecognizer:gesture];
}

- (void)needChangeImage {}

- (void)saveImage {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存图片到相册?" preferredStyle:(UIAlertControllerStyleActionSheet)];

    [controller addAction:[UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.convertImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];

    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {

    }]];

    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];

    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

    }]];

    [self presentViewController:controller animated:YES completion:nil];
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
