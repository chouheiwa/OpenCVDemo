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

@property (nonatomic, strong) NSDecimalNumberHandler *handler;

@end

@implementation HandPaintSliderView

- (NSDecimalNumberHandler *)handler {
    if (!_handler) {
        _handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:(NSRoundPlain) scale:_precision raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    }

    return _handler;
}

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

    NSDecimalNumber *number = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", value]] decimalNumberByRoundingAccordingToBehavior:self.handler];

    self.textField.text = number.stringValue;
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

    NSDecimalNumber *number = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", num]] decimalNumberByRoundingAccordingToBehavior:self.handler];

    textField.text = number.stringValue;

    if (self.valueChangeBlock) {
        self.valueChangeBlock(number.doubleValue);
    }
}

- (void)sliderDidSlide {
    CGFloat value = _slider.value;

    NSDecimalNumber *number = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", value]] decimalNumberByRoundingAccordingToBehavior:self.handler];

    _textField.text = number.stringValue;

    self.value = number.doubleValue;

    if (self.valueChangeBlock) {
        self.valueChangeBlock(number.doubleValue);
    }
}

@end
