//
//  UIViewController+CurrentViewController.m
//  OpenCVDemo
//
//  Created by Di on 2019/5/31.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

#import "UIViewController+CurrentViewController.h"

@implementation UIViewController (CurrentViewController)

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        return vc;
    }
}
+ (UIViewController *)currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;

    viewController = [UIViewController findBestViewController:viewController];
    return viewController;
}

- (void)clearKeyBoard {
    [UIViewController clearKeyBoardToView:self.view];
}

+ (void)clearKeyBoardToView:(UIView *)view {
    for (UIView *item in view.subviews) {
        if ([item isKindOfClass:[UITextField class]] || [item isKindOfClass:[UITextView class]]) {
            UITextField *textField = (UITextField *)item;

            if (textField.isEditing) {
                [textField endEditing:YES];
                break;
            }

        }

        if (item.subviews.count) {
            [self clearKeyBoardToView:item];
        }
    }
}

@end
