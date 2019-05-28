//
//  BaseTableViewCell.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/27.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAction.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, weak) BaseAction *model;

@end

NS_ASSUME_NONNULL_END
