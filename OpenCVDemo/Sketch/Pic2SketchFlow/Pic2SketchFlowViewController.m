//
//  Pic2SketchFlowViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2SketchFlowViewController.h"

@interface Pic2SketchFlowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation Pic2SketchFlowViewController
@synthesize index = _index;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.detailImageView.image = self.showImage;
    self.contentLabel.text = self.showContent;
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
