//
//  Pic2HandPrintControlView.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/30.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "Pic2HandPrintControlView.h"
#import "BaseSliderView.h"
@interface Pic2HandPrintControlView ()

@property (weak, nonatomic) IBOutlet BaseSliderView *depthSliderView;
@property (weak, nonatomic) IBOutlet BaseSliderView *ELSliderView;
@property (weak, nonatomic) IBOutlet BaseSliderView *AZSliderView;

@property (nonatomic, strong) void(^valueChangeBlock)(CGFloat depth,CGFloat elevation,CGFloat azimuth);

@end

@implementation Pic2HandPrintControlView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _depth = 3;
        _elevation = 0.45;
        _azimuth = 0.25;
    }

    return self;
}

+ (Pic2HandPrintControlView *)createFromXib {
    return [[NSBundle mainBundle] loadNibNamed:@"Pic2HandPrintControlView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    __weak typeof(self) weakSelf = self;

    [self setupSliderView:self.depthSliderView maxValue:10 minValue:0.1 currentValue:self.depth precision:1 title:@"景深" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.depth = value;

        if (self.valueChangeBlock) {
            self.valueChangeBlock(self.depth, self.elevation, self.azimuth);
        }
    }];

    [self setupSliderView:self.ELSliderView maxValue:1.5 minValue:-0.5 currentValue:self.elevation precision:2 title:@"光源仰角" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.elevation = value;

        if (self.valueChangeBlock) {
            self.valueChangeBlock(self.depth, self.elevation, self.azimuth);
        }
    }];

    [self setupSliderView:self.AZSliderView maxValue:2 minValue:0 currentValue:self.azimuth precision:2 title:@"光源倾角" changeBlock:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;

        self.azimuth = value;

        if (self.valueChangeBlock) {
            self.valueChangeBlock(self.depth, self.elevation, self.azimuth);
        }
    }];
}

- (void)setupSliderView:(BaseSliderView *)view maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue currentValue:(CGFloat)currentValue precision:(short)precision title:(NSString *)title changeBlock:(void(^)(CGFloat value))block {
    view.precision = precision;

    view.maxValue = maxValue;

    view.minValue = minValue;

    view.value = currentValue;

    view.title = title;

    view.valueChangeBlock = block;
}

- (void)valueDidChange:(void (^)(CGFloat, CGFloat, CGFloat))changeBlock {
    self.valueChangeBlock = changeBlock;
}

@end
