//
//  UIAlertController+AP.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/30/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (AP)

+ (UIAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message;
+ (UIAlertController*)alertWithOfflineError;

@end
