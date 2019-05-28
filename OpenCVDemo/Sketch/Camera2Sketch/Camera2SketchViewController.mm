//
//  Camera2SketchViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//
#import <opencv2/videoio/cap_ios.h>
#import "Camera2SketchViewController.h"

#import "OpenCVHelper.h"
#import "BaseAction.h"

@interface Camera2SketchViewController () <CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *camerImageView;

@property (nonatomic, strong) CvVideoCamera *videoCamera;

@property (weak, nonatomic) IBOutlet UIView *cameraView;

@end

@implementation Camera2SketchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    CvVideoCamera *videoCamera = [[CvVideoCamera alloc] initWithParentView:self.cameraView];
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    videoCamera.defaultFPS = 30;
    videoCamera.grayscaleMode = NO;
    videoCamera.delegate = self;
    videoCamera.useAVCaptureVideoPreviewLayer = NO;

    _videoCamera = videoCamera;

    [videoCamera start];
}

- (void)processImage:(cv::Mat &)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.camerImageView.image = [[OpenCVHelper shareInstance] getSketchImage:image];
    });
}

+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"摄像头转素描画";

    action.index = 1;

    action.section = 1;

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
