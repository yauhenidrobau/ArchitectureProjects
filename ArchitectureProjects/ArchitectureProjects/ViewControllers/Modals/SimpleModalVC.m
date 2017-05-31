//
//  SimpleModalVC.m
//  IPadPlayer_v1.0

#import "SimpleModalVC.h"

@interface SimpleModalVC ()

@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation SimpleModalVC

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.modalTitle;
    self.messageLabel.text = self.modalMessage;

//    self.modalView.layer.borderWidth = 2;
    self.modalView.layer.cornerRadius = 15;

    self.modalView.layer.borderColor = [UIColor blackColor].CGColor;
    self.titleLabel.textColor = [UIColor blackColor];
    self.okButton.tintColor = [UIColor blueColor];
}

#pragma mark IBActions

- (IBAction)okButtonTouched:(id)sender {
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock ();
    }
}

@end
