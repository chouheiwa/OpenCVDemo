//
//  Pic2HandPrintViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2HandPrintViewController.h"
#import "BaseAction.h"

#import "HandPaintHelper.h"
#import "Pic2HandPrintControlView.h"
#import "BaseSliderView.h"

@interface Pic2HandPrintViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) Pic2HandPrintControlView *controlView;

@property (nonatomic, strong) HandPaintHelper *helper;

@property (nonatomic, strong) UIImage *showImage;

@end

@implementation Pic2HandPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图片转手绘画";

    self.controlView = [Pic2HandPrintControlView createFromXib];

    [self addArrangedSubview:self.controlView];
    // Do any additional setup after loading the view from its nib.
    _helper = [[HandPaintHelper alloc] init];

    __weak typeof(self) weakSelf = self;

    [_controlView valueDidChange:^(CGFloat depth, CGFloat elevation, CGFloat azimuth) {
        __strong typeof(weakSelf) self = weakSelf;

        UIImage *convertImage = [self.helper processImage:self.showImage depth:depth elevation:elevation azimuth:azimuth];

        [self changeOriginImage:self.showImage convertImage:convertImage];
    }];

    self.showImage = [UIImage imageNamed:@"handPaint.jpg"];
}

- (void)setShowImage:(UIImage *)showImage {
    _showImage = showImage;

    UIImage *convertImage = [self.helper processImage:showImage depth:self.controlView.depth elevation:self.controlView.elevation azimuth:self.controlView.azimuth];

    [self changeOriginImage:showImage convertImage:convertImage];
}

- (void)needChangeImage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换图片" message:@"请选择想要更换的图片类型" preferredStyle:(UIAlertControllerStyleActionSheet)];

    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];

        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //设置代理
        picker.delegate = self;
        //打开相册
        [self presentViewController:picker animated:YES completion:nil];
    }]];


    [alert addAction:[UIAlertAction actionWithTitle:@"内置图片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {

    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    self.showImage = image;

    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"图片转手绘画";

    action.detail = @"这个功能是将图片转换成具有手绘感觉的效果图片。\n对于整体构图比较空旷的风景效果较好，人物等效果很差";

    action.index = 0;

    action.section = 2;

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
