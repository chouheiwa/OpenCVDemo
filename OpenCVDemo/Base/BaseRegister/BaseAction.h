//
//  BaseAction.h
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^JumpBlock)(UINavigationController *navigationController);

@interface BaseAction : NSObject

/**
 在TableView中的排序，越小排在越上面(数字相同，则按照读取顺序)
 */
@property (nonatomic, assign) NSInteger index;

/**
 在TableView中的所属组，section相同则放入同一组
 */
@property (nonatomic, assign) NSInteger section;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 内容
 */
@property (nonatomic, copy) NSString *detail;
/**
 跳转回调
 */
@property (nonatomic, copy) JumpBlock jumpAction;

@end

NS_ASSUME_NONNULL_END
