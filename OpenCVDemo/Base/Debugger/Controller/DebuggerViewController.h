//
//  DebuggerViewController.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 这个类是为了方便调试OpenCV效果中的过程显示相关参数对应修改的image过程的
 */
@interface DebuggerViewController : UITableViewController

+ (DebuggerViewController *)shareInstance;

- (void)show;

@end

NS_ASSUME_NONNULL_END
