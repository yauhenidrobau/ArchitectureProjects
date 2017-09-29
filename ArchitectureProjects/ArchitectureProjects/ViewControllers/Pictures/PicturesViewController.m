//
//  PicturesViewController.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/26/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "PicturesViewController.h"
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import "Macros.h"
#import "APRealmManager.h"
#import "Utils.h"
#import "UIImage+Smart.h"
#import "APRealmManager.h"
#import "UserImage.h"
#import "PictureCollectionViewCell.h"
#import "FontHelper.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "SimpleModalVC.h"
#import "UIViewController+ShowModal.h"

@interface PicturesViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PictureCollectionViewCellDelegate, MFMailComposeViewControllerDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *makePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseImageButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *mesageTF;
@property (strong, nonatomic) RLMResults *images;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *imagesForSendingLabel;
@end

@implementation PicturesViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.mesageTF.delegate = self;
    
    [self prepareAppearance];
    self.images = [UserImage allObjects];
    
}

#pragma mark - IBActions

- (IBAction)makePhotoTouched:(id)sender {
    if([PHPhotoLibrary authorizationStatus]) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            [self showCamera];
        }
    } else {
        WEAK(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            STRONG(self);
            if (status == PHAuthorizationStatusAuthorized) {
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                    [self showCamera];
                }
            }
        }];
    }
    
}
- (IBAction)chooseImagesTouched:(id)sender {
    if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        [self showPhotoLibrary];
    } else {
        WEAK(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            STRONG(self);
            if (status == PHAuthorizationStatusAuthorized) {
                [self showPhotoLibrary];
            }
        }];
    }
}
- (IBAction)sendTouched:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        
        [mailCont  setSubject:@"Вопрос по проектам"];
        [mailCont setToRecipients:[NSArray arrayWithObject:BASE_EMAIL]];
        [mailCont setMessageBody:[NSString stringWithFormat:@"%@",self.mesageTF.text] isHTML:NO];
        for (UserImage *image in self.images) {
            [mailCont addAttachmentData:image.imageData mimeType:@"image/jpg" fileName:[NSString stringWithFormat:@"image - %ld",image.imageId]];
        }
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *message = @"";
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            message = NSLocalizedString(@"Mail saved",nil);
            break;
        case MFMailComposeResultSent:
            [[APRealmManager sharedInstance] removeAllItemsForClass:@"UserImage"];
            message = NSLocalizedString(@"Mail sent",nil);
            break;
        case MFMailComposeResultFailed:
            message = NSLocalizedString(@"Mail sent failure",nil);
            break;

        default:
            break;
    }
    if (message.length) {
        [self showSimpleModalWithMessage:message];
    }

    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:NSLocalizedString(@"not.found.title", nil)];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"notFound"];
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellDelegate = self;
    cell.indexpath = indexPath;
    UserImage *image = self.images[indexPath.row];
    [cell updateCellWithImage:image];
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
    float koeff = 1.0;
    NSData *resizedImageData = UIImageJPEGRepresentation(image, koeff);

    while ( resizedImageData.length > imageData.length / 2) {
        koeff = koeff-0.1;
        resizedImageData = UIImageJPEGRepresentation(image, koeff);
    }
    [[APRealmManager sharedInstance] saveUserImage:[UIImage  imageWithData:resizedImageData]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PictureCollectionViewCellDelegate

- (void)cellDidRemoveItem:(UserImage*)item forIndexPath:(NSIndexPath*)indexPath {
    
    [[APRealmManager sharedInstance] removeItem:item];
    self.images = [UserImage allObjects];
    [self.collectionView reloadData];
}

#pragma mark - Private

- (void)prepareAppearance {
    [self.sendButton setTitle:NSLocalizedString(@"pictures_send.title", nil) forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = FONT(FTCochin, 18);
    self.mesageTF.placeholder = NSLocalizedString(@"pictures_message.placeholder", nil);
    [self.makePhotoButton setTitle:NSLocalizedString(@"pictures.makePhoto", nil) forState:UIControlStateNormal];
    [self.chooseImageButton setTitle:NSLocalizedString(@"pictures.chooseImage", nil) forState:UIControlStateNormal];
    self.imagesForSendingLabel.text = NSLocalizedString(@"pictures.imagesForSending.title", nil);
    self.imagesForSendingLabel.font = FONT(FTCochin, 18);

    self.makePhotoButton.layer.cornerRadius = CGRectGetHeight(self.makePhotoButton.frame) / 2;
    self.chooseImageButton.layer.cornerRadius = CGRectGetHeight(self.chooseImageButton.frame) / 2;

}

- (void)showSimpleModalWithMessage:(NSString*)message {
    [self showModalViewControllerWithIdentifier:@"SimpleModalVC" setupBlock:^(ModalViewController *modal) {
        SimpleModalVC *vc = (SimpleModalVC*)modal;
        vc.modalMessage = message;
        dispatch_async(dispatch_get_main_queue(), ^{
            [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
                if ([vc isViewLoaded]) {
                    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
                        vc.closeButtonTappedBlock();
                        [self.collectionView reloadData];
                    }];
                }
            }];
        });
    }];
}
- (void)showCamera {
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    vc.delegate = self;
    vc.allowsEditing = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showPhotoLibrary {
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    vc.delegate = self;
    vc.allowsEditing = YES;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
