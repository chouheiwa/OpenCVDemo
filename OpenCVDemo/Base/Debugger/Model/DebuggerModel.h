//
//  DebuggerModel.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebuggerModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *contentImage;

@property (nonatomic, copy) NSArray *controlsArray;

@property (nonatomic, copy) void (^valueChangeBlock) (NSArray <NSNumber *>*changeArray);

@end

NS_ASSUME_NONNULL_END
