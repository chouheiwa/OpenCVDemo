//
//  VideoViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Video2CharViewController.h"
#import "OpenCVHelper.h"
#import "CVAnimateStringModel.h"
#import "CVVideoModel.h"

#import "BaseActionProtocol.h"
#import "BaseAction.h"
@interface Video2CharViewController () <BaseActionProtocol>
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) CVVideoModel *videoModel;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL animationStart;

@end

@implementation Video2CharViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     NSString *string = [[NSBundle mainBundle] pathForResource:@"BadApple" ofType:@"mp4"];

    SizeT size;
    size.width = 64;
    size.height = 48;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CVVideoModel *videoModel = [[OpenCVHelper shareInstance] processVideo:string withSize:size processPercent:^(CGFloat percent) {
            self.imageLabel.text = [NSString stringWithFormat:@"加载进度: %.2f%%", percent * 100];
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.videoModel = videoModel;
        });
    });

//    _imageLabel.font = [OpenVCHelper defaultFont];

    _imageLabel.text = @"正在加载中...";
}

- (void)setVideoModel:(CVVideoModel *)videoModel {
    _videoModel = videoModel;
    [self startAnimate];

}

- (void)startAnimate {
    if (_animationStart) return;

    _animationStart = true;

    self.imageLabel.font = [OpenCVHelper defaultFont];

    [self showAnimate];
}

- (void)showAnimate {
    if (_currentIndex >= self.videoModel.animatedList.count) return;
 
    CVAnimateStringModel *model = self.videoModel.animatedList[self.currentIndex];

    self.imageLabel.text = model.animateString;

    self.imageView.image = model.image;

    self.currentIndex ++;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.videoModel.frameDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAnimate];
    });
}

+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"视频转字符画";

    action.index = 2;

    action.section = 0;

    action.sectionTitle = @"字符画";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
