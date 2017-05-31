//
//  UIAlertController+AP.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/30/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "UIAlertController+AP.h"

@implementation UIAlertController (AP)

+ (UIAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"alert.button.ok", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [okAction setValue:[UIColor redColor] forKey:@"titleTextColor"];

    [alertController addAction:okAction];
    return alertController;
}

+ (UIAlertController*)alertWithOfflineError {
    return [UIAlertController alertWithTitle:NSLocalizedString(@"alert.offline.title", nil) message:NSLocalizedString(@"alert.offline.message", nil)];
}

@end
