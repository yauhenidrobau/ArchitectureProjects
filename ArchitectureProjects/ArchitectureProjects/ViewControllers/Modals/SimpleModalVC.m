//
//  SimpleModalVC.m

#import "SimpleModalVC.h"

@interface SimpleModalVC ()

@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *modalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *modalMessageLabel;

@end

@implementation SimpleModalVC

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.modalTitleLabel.text = self.modalTitle;
    self.modalMessageLabel.text = self.modalMessage;

    self.modalView.layer.borderWidth = 2;
    self.modalView.layer.cornerRadius = 15;

    self.modalView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.okButton.tintColor = [UIColor blueColor];
}

#pragma mark IBActions

- (IBAction)okButtonTouched:(id)sender {
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock ();
    }
}

@end
