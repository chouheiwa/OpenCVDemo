//
//  BaseTableViewCell.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/27.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(BaseAction *)model {
    _model = model;

    if (model.detail.length == 0) {
        [_stackView removeArrangedSubview:_detailLabel];
    } else if (model.detail.length != 0 && ![_stackView.arrangedSubviews containsObject:_detailLabel]) {
        [_stackView addArrangedSubview:_detailLabel];
    }

    _titleLabel.text = model.title;

    _detailLabel.text = model.detail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
