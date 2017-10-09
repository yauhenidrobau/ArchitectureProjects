//
//  UIViewController+RevealViewController.m
//  DayTracker
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "UIViewController+RevealViewController.h"

#import <SWRevealViewController.h>
#import "UIAlertController+AP.h"
#import "UIColor+App.h"

@implementation UIViewController (RevealViewController)

- (void)setupRevealViewController {
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController && !self.navigationItem.leftBarButtonItem) {
        UIImage *image = [UIImage imageNamed:@"menuIcon"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        button.tintColor = [UIColor app_secondColor];
        [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
        [self.view addGestureRecognizer:tap];
        self.navigationController.navigationBar.barTintColor = [UIColor app_mainColor];

        
    }
}

- (void)showErrorAlertWithMessage:(NSString*)message {
    [self showAlertWithTitle:NSLocalizedString(@"alert.error.title", nil) andMessage:message];
}

- (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message {
    UIAlertController* alert = [UIAlertController alertWithTitle:title message:message];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
