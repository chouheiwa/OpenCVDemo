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
@interface Pic2HandPrintViewController ()<BaseActionProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Pic2HandPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    HandPaintHelper *helper = [[HandPaintHelper alloc] init];

    self.imageView.image = [helper processImage:[UIImage imageNamed:@"handPaint.jpg"]];
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

    action.title = @"图片转手绘";

    action.index = 0;

    action.section = 2;

    action.sectionTitle = @"手绘画";

    action.jumpAction = ^(UINavigationController * _Nonnull navigationController) {
        [navigationController pushViewController:[[self alloc] init] animated:YES];
    };

    return action;
}

@end
