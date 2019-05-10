//
//  AnimatedFlowViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/22.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "StringFlowViewController.h"
#import "StringFinalStepViewController.h"

#import "OpenCVHelper.h"


@interface StringFlowViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImageVIew;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@end

@implementation StringFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_step) {
        case FlowStepFirst: {
            self.title = @"第一步";
            self.stepLabel.text = @"展示原图";
            self.showImageVIew.image = self.showImage;
            self.firstStepImage = self.showImage;
        }
            break;
        case FlowStepSecond: {
            self.title = @"第二步";
            self.stepLabel.text = @"将原图压缩到指定大小(64 * 48)，压缩是为了保证最终字符串不会太多以至于屏幕显示不开";
            SizeT size;
            size.height = 48;
            size.width = 64;
            self.showImageVIew.image = [[OpenCVHelper shareInstance] resizeImage:self.showImage withSize:size];
        }
            break;
        case FlowStepThird: {
            self.title = @"第三步";
            self.stepLabel.text = @"将压缩图转换成灰度图";
            UIImage *grayImage = [[OpenCVHelper shareInstance] grayImage:self.showImage];

            self.showImageVIew.image = grayImage;
            NSLog(@"压缩图像大小: %@; 压缩图像比例: %f", NSStringFromCGSize(self.showImage.size), self.showImage.scale);

            NSLog(@"灰度图像大小: %@; 灰度图像比例: %f", NSStringFromCGSize(grayImage.size), grayImage.scale);
        }
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"图像大小:%@",NSStringFromCGSize(self.showImageVIew.frame.size));
}

- (IBAction)nextStep:(id)sender {
    UIViewController *vc = nil;

    switch (self.step) {
        case FlowStepThird: {
            CVAnimateStringModel *model = [[CVAnimateStringModel alloc] init];

            model.animateString = [[OpenCVHelper shareInstance] convertImage:self.showImageVIew.image];

            StringFinalStepViewController *viewController = [StringFinalStepViewController new];

            viewController.firstStepImage = self.firstStepImage;

            viewController.model = model;

            vc = viewController;

            break;
        }
        default: {
            StringFlowViewController *viewController = [StringFlowViewController new];

            viewController.showImage = self.showImageVIew.image;

            viewController.step = FlowStep(self.step + 1);

            viewController.firstStepImage = self.firstStepImage;

            vc = viewController;

            break;
        }
    }

    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
