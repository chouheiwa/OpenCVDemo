//
//  BaseRegister.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/9.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "BaseRegister.h"
#import <objc/runtime.h>
#import "BaseAction.h"
#import "BaseActionProtocol.h"
#import "BaseSection.h"
#import "BaseSectionProtocol.h"

@interface BaseRegister ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation BaseRegister
static BaseRegister *instance = nil;
+ (void)start {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseRegister alloc] init];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        Protocol *protocol = @protocol(BaseSectionProtocol);

        int numberOfClasses = objc_getClassList(NULL, 0);
        Class *classList = (__unsafe_unretained Class *)malloc(numberOfClasses * sizeof(Class));
        numberOfClasses = objc_getClassList(classList, numberOfClasses);

        NSMutableArray <BaseSection *>*dataArray = [NSMutableArray arrayWithCapacity:20];

        for (int idx = 0; idx < numberOfClasses; idx++)
        {
            Class class = classList[idx];

            BOOL resultConfirmProtocol = class_getClassMethod(class, @selector(conformsToProtocol:)) && [class conformsToProtocol:protocol];

            if (resultConfirmProtocol)
            {
                BaseSection *section = [class performSelector:@selector(confirmSection)];

                [dataArray addObject:section];
            }
        }

        [dataArray sortUsingComparator:^NSComparisonResult(BaseSection * _Nonnull obj1, BaseSection * _Nonnull obj2) {
            return obj1.index > obj2.index;
        }];

        self.dataArray = dataArray;
        free(classList);
    }
    return self;
}

+ (NSArray<BaseSection *> *)sections {
    return instance.dataArray;
}

@end
