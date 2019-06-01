//
//  DebuggerViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "DebuggerViewController.h"
#import "UIViewController+CurrentViewController.h"

@interface DebuggerViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DebuggerViewController

+ (DebuggerViewController *)shareInstance {
    static DebuggerViewController *viewController = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewController = [[DebuggerViewController alloc] init];
    });

    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemStop) target:self action:@selector(close)];

    self.title = @"参数调试";

    
}

- (void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)show {
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self];

    [[UIViewController currentViewController] presentViewController:navi animated:YES completion:nil];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
