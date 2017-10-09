//
//  SimpleModalVC.h
//  IPadPlayer_v1.0

#import <UIKit/UIKit.h>
#import "ModalViewController.h"

@interface SimpleModalVC : ModalViewController

@property (strong, nonatomic) void (^closed)();
@property (nonatomic, strong) NSString *modalMessage;
@property (nonatomic, strong) NSString *modalTitle;

@end
