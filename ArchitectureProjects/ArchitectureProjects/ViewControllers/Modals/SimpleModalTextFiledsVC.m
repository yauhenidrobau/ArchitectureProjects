//
//  SimpleModalTextFiledsVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/30/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "SimpleModalTextFiledsVC.h"

#import "UIColor+App.h"
#import <Canvas/Canvas.h>

@interface SimpleModalTextFiledsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UITextField *projectNumber;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;

@end

@implementation SimpleModalTextFiledsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.projectNumber.hidden = !self.showProjectField;
    self.projectTitleLabel.hidden = !self.showProjectField;
    
    [self.phoneTF becomeFirstResponder];
    self.titleLabel.textColor = [UIColor app_secondColor];
    self.projectTitleLabel.textColor = [UIColor app_secondColor];

    [self.okButton setTitleColor:[UIColor app_secondColor] forState:UIControlStateNormal];
    self.addressTF.backgroundColor = [UIColor app_mainColor];
    [self.addressTF setPlaceholderColor:[UIColor whiteColor]];
    self.addressTF.textColor = [UIColor app_secondColor];
    self.addressTF.tintColor = [UIColor app_secondColor];
    self.addressTF.layer.borderColor = [UIColor whiteColor].CGColor;
    self.addressTF.layer.borderWidth = 1;
    
    self.phoneTF.backgroundColor = [UIColor app_mainColor];
    self.phoneTF.textColor = [UIColor app_secondColor];
    [self.phoneTF setPlaceholderColor:[UIColor whiteColor]];
    self.phoneTF.tintColor = [UIColor app_secondColor];
    self.phoneTF.layer.borderColor = [UIColor whiteColor].CGColor;
    self.phoneTF.layer.borderWidth = 1;

    self.projectNumber.backgroundColor = [UIColor app_mainColor];
    self.projectNumber.textColor = [UIColor app_secondColor];
    [self.projectNumber setPlaceholderColor:[UIColor whiteColor]];
    self.projectNumber.tintColor = [UIColor app_secondColor];
    self.projectNumber.layer.borderColor = [UIColor whiteColor].CGColor;
    self.projectNumber.layer.borderWidth = 1;

    self.modalView.backgroundColor = [UIColor app_mainColor];
    self.modalView.layer.cornerRadius = 15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phoneTF) {
        [textField resignFirstResponder];
        [self.addressTF becomeFirstResponder];
    } else if (textField == self.addressTF) {
        [textField resignFirstResponder];
        [self.projectNumber becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;
}
#pragma mark - IBActions

- (IBAction)okButtonTouched:(id)sender {
    [self close];
}

- (void)close {
    if (self.phoneTF.text.length && self.addressTF.text.length && self.projectNumber.text.length) {
       if (self.closedWithData) {
            self.closedWithData(self.phoneTF.text, self.addressTF.text, self.projectNumber.text);
        }
        if (self.closeButtonTappedBlock) {
            self.closeButtonTappedBlock ();
        }
    } else {
        if (self.closeButtonTappedBlock) {
            self.closeButtonTappedBlock ();
        }
    }
}

@end
