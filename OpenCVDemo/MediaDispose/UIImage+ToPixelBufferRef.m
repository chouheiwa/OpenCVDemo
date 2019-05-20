//
//  UIImage+toPixelBufferRef.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/15.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "UIImage+ToPixelBufferRef.h"

@implementation UIImage (ToPixelBufferRef)

- (CVPixelBufferRef)pixelBufferRefWithSize:(CGSize)size {
    NSInteger width = size.width;

    NSInteger height = size.height;

    CVPixelBufferRef buffer;

    NSDictionary *options = @{((__bridge NSString *) kCVPixelBufferCGImageCompatibilityKey): @(true), ((__bridge NSString *)kCVPixelBufferCGBitmapContextCompatibilityKey): @(true)};

    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, ((__bridge_retained CFDictionaryRef)options), &buffer);

    if (status != kCVReturnSuccess) return nil;

    CVPixelBufferLockBaseAddress(buffer, 0);

    void *pixelData = CVPixelBufferGetBaseAddress(buffer);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef ref = CGBitmapContextCreate(pixelData, width, height, 8, CVPixelBufferGetBytesPerRow(buffer), colorSpace, kCGImageAlphaFirst);

    UIGraphicsPushContext(ref);

    CGContextTranslateCTM(ref, 0, height);

    CGContextScaleCTM(ref, 1, -1);

    [self drawInRect:CGRectMake(0, 0, width, height)];

    UIGraphicsPopContext();

    CVPixelBufferUnlockBaseAddress(buffer, 0);

    return buffer;
}

@end
