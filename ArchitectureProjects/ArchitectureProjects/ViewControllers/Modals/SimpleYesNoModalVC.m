//
//  SimpleYesNoModalVC.m
//  IPadPlayer_v1.0


#import "SimpleYesNoModalVC.h"

@interface SimpleYesNoModalVC ()

@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@end

@implementation SimpleYesNoModalVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.mainTitle;
    self.modalView.layer.cornerRadius = 15;
    self.modalView.layer.borderColor = [UIColor blackColor].CGColor;
    self.titleLabel.textColor = [UIColor blackColor];
    self.yesButton.tintColor = [UIColor blueColor];
    self.noButton.tintColor = [UIColor blueColor];
    [self.noButton setTitle:NSLocalizedString(@"No", nil) forState:UIControlStateNormal];
    [self.yesButton setTitle:NSLocalizedString(@"Yes", nil) forState:UIControlStateNormal];

}

- (IBAction)yesButtontouched:(id)sender {
    if (self.closed) {
        self.closed(YES);
    }
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock();
    }
}

- (IBAction)noButtonTouched:(id)sender {
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock();
    }
}

@end
