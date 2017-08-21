//
//  BaseViewController.m
//  DayTracker
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "BaseViewController.h"

#import "UIViewController+RevealViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupRevealViewController];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
