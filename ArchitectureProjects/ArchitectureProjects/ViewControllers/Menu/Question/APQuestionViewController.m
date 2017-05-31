//
//  APQuestionViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APQuestionViewController.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "NSString+AP.h"
#import "Macros.h"
#import "Utils.h"
#import "UIViewController+ShowModal.h"
#import "SimpleModalVC.h"

@interface APQuestionViewController () <MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation APQuestionViewController

#pragma mark LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareAppierance];
    [self configSendButton];
    [self.sendButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sendEmail {
    // From within your active view controller
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        
        [mailCont  setSubject:@"Вопрос по проектам"];
        [mailCont setToRecipients:[NSArray arrayWithObject:BASE_EMAIL]];
        [mailCont setMessageBody:[NSString stringWithFormat:@"%@ /n/n %@",self.emailTextField.text,self.messageTextView.text ] isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if (!error) {
        [self showModalViewControllerWithIdentifier:SIMPLE_MODAL_ID setupBlock:^(ModalViewController *modal) {
            SimpleModalVC *vc = (SimpleModalVC*)modal;
            vc.modalMessage = NSLocalizedString(@"menu.question.sent.message", nil);
            vc.modalTitle = NSLocalizedString(@"menu.question.sent.title", nil);

        } animated:YES];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self configSendButton];
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self configSendButton];
    return YES;

}

#pragma mark - Private

-(void)configSendButton {
    BOOL isEnabled = (self.emailTextField.text.length && self.messageTextView.text.length);
    [self.sendButton setEnabled:isEnabled];

    if (isEnabled) {
        self.sendButton.backgroundColor = [UIColor colorWithRed:20.0 / 255.0 green:74.0 / 255.0 blue:146.0 / 255.0 alpha:1];
    } else {
        self.sendButton.backgroundColor = [UIColor grayColor];
    }
}

-(void)prepareAppierance {
    self.sendButton.layer.cornerRadius = self.sendButton.frame.size.height / 2;
}
@end
