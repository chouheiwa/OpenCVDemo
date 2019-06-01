//
//  DebuggerTableViewCell.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "DebuggerTableViewCell.h"

@interface DebuggerTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIStackView *controlStackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end

@implementation DebuggerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
