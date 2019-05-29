//
//  BasicViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/4/17.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BasicViewController.h"
#import "BaseAction.h"
#import "BaseSection.h"
#import "BaseRegister.h"

#import "BaseTableViewCell.h"

@interface BasicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"功能列表";

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];

    _tableView.dataSource = self;
    _tableView.delegate = self;

    [_tableView registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

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
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.model = [BaseRegister sections][indexPath.section].datas[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [BaseRegister sections][section].datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [BaseRegister sections].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [BaseRegister sections][indexPath.section].datas[indexPath.row].jumpAction(self.navigationController);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];

    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    }

    view.textLabel.text = [BaseRegister sections][section].title;

    view.detailTextLabel.text = [BaseRegister sections][section].details;

    return view;
}

@end
