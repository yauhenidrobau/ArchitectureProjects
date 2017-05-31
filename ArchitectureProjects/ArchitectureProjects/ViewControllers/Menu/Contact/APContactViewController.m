//
//  APContactViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APContactViewController.h"

#import <SafariServices/SafariServices.h>
#import "Macros.h"
#import "UIViewController+RevealViewController.h"

@interface APContactViewController () <SFSafariViewControllerDelegate>

@end

@implementation APContactViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
- (IBAction)vkButtonTouched:(id)sender {
    [self openSafaryWithURL:[NSURL URLWithString:VK_URL]];
}

- (IBAction)instagramButtonTouched:(id)sender {
    [self openSafaryWithURL:[NSURL URLWithString:INSTAGRAM_URL]];
}

- (IBAction)telButtonTouched:(UIButton*)sender {
    NSString *phoneNumberUrl = [@"tel://" stringByAppendingString:sender.titleLabel.text];
    NSURL* phoneURL = [NSURL URLWithString:phoneNumberUrl];
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    } else {
        [self showErrorAlertWithMessage:NSLocalizedString(@"alert.phone.call.not.supported", nil)];
    }
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

-(void)openSafaryWithURL:(NSURL*)URL {
    if (![[UIApplication sharedApplication] openURL:URL]) {
        NSLog(@"%@%@",@"Failed to open url:",[URL description]);
    } else {
        if ([SFSafariViewController class] != nil) {
            SFSafariViewController *safary = [[SFSafariViewController alloc] initWithURL:URL];
            safary.delegate = self;
            [self presentViewController:safary animated:YES completion:nil];
        }
    }
}
@end
