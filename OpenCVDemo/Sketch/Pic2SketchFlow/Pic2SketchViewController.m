//
//  Pic2SketchViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/7.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2SketchViewController.h"
#import "Pic2SketchModel.h"

#import "Pic2SketchFlowViewController.h"

#import "BaseAction.h"

@interface Pic2SketchViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) Pic2SketchModel *model;

@property (nonatomic, copy) NSArray <UIViewController <Pic2SketchViewControllerProtocol>*>*array;

@end

@implementation Pic2SketchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图像转素描画过程";
    // Do any additional setup after loading the view from its nib.
    self.model = [[Pic2SketchModel alloc] init];

    self.array = [self.model getObjectsFromBlock:^id _Nonnull(UIImage * _Nonnull image, NSString * _Nonnull content, NSInteger index) {
        Pic2SketchFlowViewController *vc = [[Pic2SketchFlowViewController alloc] init];

        vc.showImage = image;
        vc.showContent = content;
        vc.index = index;

        return vc;
    }];

    UIPageViewController *controller = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];

    [controller setViewControllers:@[self.array.firstObject] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];

    controller.delegate = self;
    controller.dataSource = self;

    controller.view.frame = self.view.frame;

    controller.view.backgroundColor = [UIColor whiteColor];

    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController <Pic2SketchViewControllerProtocol>*)viewController {
    if (viewController.index == self.array.count - 1) {
        return nil;
    }

    return self.array[viewController.index + 1];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController <Pic2SketchViewControllerProtocol>*)viewController {
    if (viewController.index == 0) {
        return nil;
    }

    return self.array[viewController.index - 1];
}


+ (nonnull BaseAction *)confirmAction {
    BaseAction *action = [[BaseAction alloc] init];

    action.title = @"图片转素描画";

    action.index = 0;

    action.section = 1;

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[Pic2SketchViewController alloc] init] animated:YES];
    };

    return action;
}

@end
