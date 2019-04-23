//
//  BasicViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/17.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BasicViewController.h"
#import "VideoViewController.h"
#import "CameraViewController.h"

#import "StringFlowViewController.h"

@interface BasicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"功能列表";

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];

    _tableView.dataSource = self;
    _tableView.delegate = self;

    [self.view addSubview:_tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"图像转字符串过程";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"摄像头动画";
    } else {
        cell.textLabel.text = @"视频动画";
    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        StringFlowViewController *vc = [StringFlowViewController new];

        vc.showImage = [UIImage imageNamed:@"Example.jpg"];

        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[CameraViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[VideoViewController new] animated:YES];
    }
}

@end
