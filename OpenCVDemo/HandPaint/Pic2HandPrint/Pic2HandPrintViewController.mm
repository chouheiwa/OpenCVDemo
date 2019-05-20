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

@interface Pic2HandPrintViewController ()<BaseActionProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *convertImageView;

@property (weak, nonatomic) IBOutlet HandPaintSliderView *depthSliderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightLayout;

@end

@implementation Pic2HandPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图片转手绘画";
    // Do any additional setup after loading the view from its nib.
    HandPaintHelper *helper = [[HandPaintHelper alloc] init];

    self.originImageView.image = [UIImage imageNamed:@"handPaint.jpg"];

    self.depthSliderView.maxValue = 10;

    self.depthSliderView.minValue = 0.1;

    self.depthSliderView.value = 3;

    self.depthSliderView.title = @"景深";

    __weak typeof(self) weakSelf = self;

    self.depthSliderView.valueChangeBlock = ^(CGFloat value) {
        weakSelf.convertImageView.image = [helper processImage:self.originImageView.image depth:value];
    };

    self.convertImageView.image = [helper processImage:self.originImageView.image depth:self.depthSliderView.value];

    [self resizeImageView];
}

- (void)resizeImageView {
    UIImage *image = self.originImageView.image;

    CGSize size = image.size;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGFloat height = width / size.width * size.height;

    self.imageHeightLayout.constant = height;
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
