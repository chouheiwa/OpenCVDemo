//
//  Pic2HandPrintViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2HandPrintViewController.h"
#import "BaseAction.h"
#import "BaseActionProtocol.h"

#import "HandPaintHelper.h"
#import "HandPaintSliderView.h"

@interface Pic2HandPrintViewController ()<BaseActionProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *convertImageView;

@property (weak, nonatomic) IBOutlet HandPaintSliderView *depthSliderView;
@property (weak, nonatomic) IBOutlet HandPaintSliderView *ELSliderView;

@property (weak, nonatomic) IBOutlet HandPaintSliderView *AZSliderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightLayout;

@property (nonatomic, strong) HandPaintHelper *helper;

@end

@implementation Pic2HandPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图片转手绘画";
    // Do any additional setup after loading the view from its nib.
    _helper = [[HandPaintHelper alloc] init];

    [self.originImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage)]];

    __weak typeof(self) weakSelf = self;

    [self setupSliderView:self.depthSliderView maxValue:10 minValue:0.1 currentValue:3 precision:1 title:@"景深" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.convertImageView.image = [self.helper processImage:self.originImageView.image depth:value elevation:self.ELSliderView.value azimuth:self.AZSliderView.value];
    }];

    [self setupSliderView:self.ELSliderView maxValue:1.5 minValue:-0.5 currentValue:0.45 precision:2 title:@"光源仰角" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.convertImageView.image = [self.helper processImage:self.originImageView.image depth:self.depthSliderView.value elevation:value azimuth:self.AZSliderView.value];
    }];

    [self setupSliderView:self.AZSliderView maxValue:2 minValue:0 currentValue:0.25 precision:2 title:@"光源倾角" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.convertImageView.image = [self.helper processImage:self.originImageView.image depth:self.depthSliderView.value elevation:value azimuth:self.AZSliderView.value];
    }];

    [self changeOriginImage:[UIImage imageNamed:@"handPaint.jpg"]];
}

- (void)setupSliderView:(HandPaintSliderView *)view maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue currentValue:(CGFloat)currentValue precision:(short)precision title:(NSString *)title changeBlock:(void(^)(CGFloat value))block {
    view.precision = precision;

    view.maxValue = maxValue;

    view.minValue = minValue;

    view.value = currentValue;

    view.title = title;

    view.valueChangeBlock = block;
}

- (void)changeOriginImage:(UIImage *)image {
    self.originImageView.image = image;

    self.convertImageView.image = [_helper processImage:self.originImageView.image depth:self.depthSliderView.value elevation:self.ELSliderView.value azimuth:self.AZSliderView.value];

    [self resizeImageView];
}

- (void)changeImage {
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

    [self changeOriginImage:image];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resizeImageView {
    UIImage *image = self.originImageView.image;

    CGSize size = image.size;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGFloat height = width / size.width * size.height;

    self.imageHeightLayout.constant = height;
}

+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"图片转手绘画";

    action.index = 0;

    action.section = 2;

    action.sectionTitle = @"手绘画";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
