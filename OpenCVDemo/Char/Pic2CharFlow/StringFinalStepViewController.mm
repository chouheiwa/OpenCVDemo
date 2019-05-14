//
//  AnimatedFinalStepViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/22.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "StringFinalStepViewController.h"

#import "OpenCVHelper.h"

@interface StringFinalStepViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstStepImageView;

@end

@implementation StringFinalStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"最后一步";
    self.titleLabel.text = @"拼接并渲染字符串";

    self.firstStepImageView.image = self.firstStepImage;
    self.contentLabel.font = [OpenCVHelper defaultFont];
    self.contentLabel.text = _model.animateString;
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
