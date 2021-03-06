//
//  SimpleModalVC.m
//  IPadPlayer_v1.0

#import "SimpleModalVC.h"

#import "UIColor+App.h"

@interface SimpleModalVC ()

@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation SimpleModalVC

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.modalTitle;
    self.messageLabel.text = self.modalMessage;
    self.titleLabel.textColor = [UIColor app_secondColor];
    self.messageLabel.textColor = [UIColor app_secondColor];


    self.modalView.backgroundColor = [UIColor app_mainColor];
    self.modalView.layer.cornerRadius = 15;

    self.okButton.tintColor = [UIColor app_secondColor];
    self.okButton.backgroundColor = [UIColor app_mainColor];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(close) userInfo:nil repeats:NO];
}

#pragma mark IBActions

- (IBAction)okButtonTouched:(id)sender {
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock ();
    }
}

- (void)close {
    if (self.closed) {
        self.closed ();
    }
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock ();
    }
}
@end
