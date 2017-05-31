//
//  SimpleYesNoModalVC.h
//  IPadPlayer_v1.0


#import <UIKit/UIKit.h>
#import "ModalViewController.h"

@interface SimpleYesNoModalVC : ModalViewController

@property (nonatomic, strong) void (^closed)(BOOL isShowSmth);

@property (nonatomic, strong) NSString *mainTitle;

@end
