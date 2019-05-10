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
        Protocol *protocol = @protocol(BaseActionProtocol);

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
                BaseAction *action = [class performSelector:@selector(confirmAction)];

                BaseSection *section;

                if (action.section >= dataArray.count) {
                    section = [[BaseSection alloc] init];

                    [dataArray addObject:section];
                } else {
                    for (int i = action.section; i <= 0; i --) {
                        if (dataArray[i].index == action.section) {
                            section = dataArray[i];
                            break;
                        }
                    }

                    if (!section) {
                        section = [[BaseSection alloc] init];

                        [dataArray insertObject:section atIndex:action.section];
                    }
                }

                
            }
        }
        free(classList);
    }
    return self;
}

@end
