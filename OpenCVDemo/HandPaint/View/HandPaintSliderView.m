//
//  HandPaintSliderView.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/20.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "HandPaintSliderView.h"

@interface HandPaintSliderView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HandPaintSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setupView {
    _titleLabel = [[UILabel alloc] init];

    _titleLabel.font = [UIFont systemFontOfSize:14];

    [self addArrangedSubview:_titleLabel];

    _slider = [[UISlider alloc] init];

    [_slider addTarget:self action:@selector(sliderDidSlide) forControlEvents:(UIControlEventValueChanged)];

    [self addArrangedSubview:_slider];

    _textField = [[UITextField alloc] init];

    _textField.delegate = self;

    _textField.borderStyle = UITextBorderStyleRoundedRect;

    _textField.backgroundColor = [UIColor whiteColor];

    [self addArrangedSubview:_textField];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:60];

    [_textField addConstraint:widthConstraint];
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;

    self.slider.maximumValue = maxValue;

    if (self.value > maxValue) {
        self.value = maxValue;
    }
}

- (void)setValue:(CGFloat)value {
    _value = value;

    self.slider.value = value;

    self.textField.text = [NSString stringWithFormat:@"%.1f", value];
}

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;

    self.slider.minimumValue = minValue;

    if (self.value < minValue) {
        self.value = minValue;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *text = textField.text;

    CGFloat num = [text doubleValue];

    if (num > self.maxValue) {
        num = self.maxValue;
    } else if (num < self.minValue) {
        num = self.minValue;
    }

    textField.text = [NSString stringWithFormat:@"%.1f", num];

    if (self.valueChangeBlock) {
        self.valueChangeBlock([textField.text doubleValue]);
    }
}

- (void)sliderDidSlide {
    CGFloat value = _slider.value;

    _textField.text = [NSString stringWithFormat:@"%.1f", value];

    if (self.valueChangeBlock) {
        self.valueChangeBlock([_textField.text doubleValue]);
    }
}

@end
