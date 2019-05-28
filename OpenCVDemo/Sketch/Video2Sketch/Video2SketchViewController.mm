//
//  Video2SketchViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/14.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Video2SketchViewController.h"
#import "BaseAction.h"

#import "OpenCVHelper.h"
#import "CVSketchModel.h"

@interface Video2SketchViewController () 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic, strong) CVSketchModel *model;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL animationStart;

@end

@implementation Video2SketchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *string = [[NSBundle mainBundle] pathForResource:@"cxh" ofType:@"mp4"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CVSketchModel *model = [[OpenCVHelper shareInstance] processSketchVideo:string processPercent:^(CGFloat percent) {
            self.detailLabel.text = [NSString stringWithFormat:@"加载进度: %.2f%%", percent * 100];
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.model = model;
        });
    });
}

- (void)setModel:(CVSketchModel *)model {
    _model = model;
    [self startAnimate];
}

- (void)startAnimate {
    if (_animationStart) return;

    _animationStart = YES;

    self.detailLabel.hidden = YES;

    [self showAnimate];
}

- (void)showAnimate {
    if (_currentIndex >= self.model.animatedList.count) return;

    self.imageView.image = self.model.animatedList[_currentIndex];

    self.currentIndex ++;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.model.frameDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAnimate];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"视频转素描画";

    action.index = 2;

    action.section = 1;

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
