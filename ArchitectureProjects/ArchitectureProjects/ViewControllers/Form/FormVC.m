//
//  FormVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/24/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "FormVC.h"

#import "Utils.h"
#import "FormDataSource.h"
#import "Macros.h"
#import "UIColor+App.h"
#import <MessageUI/MessageUI.h>
#import "SimpleModalVC.h"
#import "UIViewController+ShowModal.h"

@interface FormVC () <UIScrollViewDelegate, UITableViewDelegate,MFMailComposeViewControllerDelegate, UITextViewDelegate>

//Section1
@property (weak, nonatomic) IBOutlet UILabel *section1TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section1Button;
@property (weak, nonatomic) IBOutlet UIButton *section1Button2;

//Section2
@property (weak, nonatomic) IBOutlet UILabel *section2TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section2Button;
@property (weak, nonatomic) IBOutlet UIButton *section2Button2;

//Section3
@property (weak, nonatomic) IBOutlet UILabel *section3TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section3Button;
@property (weak, nonatomic) IBOutlet UIButton *section3Button2;
@property (weak, nonatomic) IBOutlet UIButton *section3Button3;

//Section4
@property (weak, nonatomic) IBOutlet UILabel *section4TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section4Button;
@property (weak, nonatomic) IBOutlet UIButton *section4Button2;
@property (weak, nonatomic) IBOutlet UIButton *section4Button3;

//Section5
@property (weak, nonatomic) IBOutlet UILabel *section5TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section5Button;
@property (weak, nonatomic) IBOutlet UIButton *section5Button2;
@property (weak, nonatomic) IBOutlet UIButton *section5Button3;
@property (weak, nonatomic) IBOutlet UIButton *section5Button4;

//Section6
@property (weak, nonatomic) IBOutlet UILabel *section6TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section6Button;
@property (weak, nonatomic) IBOutlet UIButton *section6Button2;

//Section7
@property (weak, nonatomic) IBOutlet UILabel *section7TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section7Button;
@property (weak, nonatomic) IBOutlet UIButton *section7Button2;

//Section8
@property (weak, nonatomic) IBOutlet UILabel *section8TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *section8Button;
@property (weak, nonatomic) IBOutlet UIButton *section8Button2;
@property (weak, nonatomic) IBOutlet UIButton *section8Button3;
@property (weak, nonatomic) IBOutlet UIButton *section8Button4;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray<UILabel*> *titles;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView*> *checkedImages;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *finishFormTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *finishFormTableView;
@property (weak, nonatomic) IBOutlet UITextView *finishFormTextView;
@property (strong, nonatomic) NSArray *finishFormTitles;

@property (strong, nonatomic) FormDataSource *formDataSource;
@property (strong, nonatomic) NSMutableDictionary *formValues;
@property (weak, nonatomic) IBOutlet UIStackView *headerCheckStackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerCheckStackViewHeight;

@end

@implementation FormVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formValues = [@{}mutableCopy];
    [self prepareImages];
    
    self.finishFormTableView.delegate = self;
    self.formDataSource = [FormDataSource new];
    self.finishFormTableView.dataSource = self.formDataSource;
    [self prepareAppearance];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self prepareHeaderStackForSize:size];
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, size.width, size.height);
    [self openPage:self.pageControl.currentPage];
    [self.view layoutIfNeeded];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

#pragma mark - Actions

- (void)tapOnCheckedImage:(UITapGestureRecognizer*)recognizer {
    NSInteger tag = [self.checkedImages indexOfObject:((UIImageView*)recognizer.view)];
    [self openPage:tag];
    self.pageControl.currentPage = [self currentPage];
}

- (IBAction)answerAction:(UIButton*)sender {
    NSInteger tag = sender.superview.tag;
    self.checkedImages[tag].image = [UIImage imageNamed:@"checked"];
    [self.formValues setObject:sender.titleLabel.text forKey:self.finishFormTitles[tag]];
    self.finishFormTitleLabel.text = self.formValues.allKeys.count == self.checkedImages.count ? NSLocalizedString(@"form.finish.ready.title", nil) : NSLocalizedString(@"form.finish.notReady.title", nil);
    [self.formDataSource updateValues:self.formValues];
    [self.finishFormTableView reloadData];
    self.pageControl.currentPage = [self currentPage] + 1;
    self.sendButton.hidden = self.formValues.allKeys.count != self.checkedImages.count;
    
    NSInteger nextUncheckedIndex = -1;
    for (NSInteger i = tag; i < self.checkedImages.count; i++) {
        UIImageView *imageView = self.checkedImages[i];
        if ([Utils firstimage:imageView.image isEqualTo: [UIImage imageNamed:@"unchecked"]]) {
            nextUncheckedIndex = i;
            break;
        }
    }
    if (nextUncheckedIndex == -1) {
        for (NSInteger i = 0; i < self.checkedImages.count; i++) {
            UIImageView *imageView = self.checkedImages[i];
            if ([Utils firstimage:imageView.image isEqualTo: [UIImage imageNamed:@"unchecked"]]) {
                nextUncheckedIndex = i;
                break;
            }
        }
    }
    if (nextUncheckedIndex != -1) {
        if (self.formValues.allKeys.count == self.checkedImages.count || [self currentPage] + 1 != self.checkedImages.count) {
            [self openPage:nextUncheckedIndex];
        } else {
            for (UIImageView *imageView in self.checkedImages) {
                if ([Utils firstimage:imageView.image isEqualTo: [UIImage imageNamed:@"unchecked"]]) {
                    [self openPage:[self.checkedImages indexOfObject:imageView]];
                    break;
                }
            }
        }
    } else {
        [self openPage:self.checkedImages.count];
    }
    self.pageControl.hidden = [self currentPage] == self.pageControl.numberOfPages;
    
}
- (IBAction)sendForm:(id)sender {
    [self.formValues setObject:self.finishFormTextView.text forKey:@"Comments"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.formValues options:0 error:nil];
    NSLog(@"ns data is %@",jsonData);
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // Create URL for PDF file
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = @"form.pdf";
    NSURL *fileURL = [NSURL fileURLWithPathComponents:[NSArray arrayWithObjects:documentsDirectory, filename, nil]];
    
    // Create PDF context
    CGContextRef pdfContext = CGPDFContextCreateWithURL((CFURLRef)fileURL, NULL, NULL);
    CGPDFContextBeginPage(pdfContext, NULL);
    UIGraphicsPushContext(pdfContext);
    
    // Flip coordinate system
    CGRect bounds = CGContextGetClipBoundingBox(pdfContext);
    CGContextScaleCTM(pdfContext, 1.0, -1.0);
    CGContextTranslateCTM(pdfContext, 0.0, -bounds.size.height);
    
    // Drawing commands
    [json drawAtPoint:CGPointMake(50, 50) withAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0f]}];
    // Clean up
    UIGraphicsPopContext();
    CGPDFContextEndPage(pdfContext);
    CGPDFContextClose(pdfContext);
    
    NSString *emailTitle =  @"Анкета пользователя";
    
    NSString *messageBody = self.finishFormTextView.text;
    
    NSArray *toRecipents = [NSArray arrayWithObject:BASE_EMAIL];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc addAttachmentData:jsonData mimeType:@"application/pdf" fileName:filename];
    
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];
        
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
            self.formValues = [@{}mutableCopy];
            [self.formDataSource updateValues:self.formValues];
            [self.finishFormTableView reloadData];
            [self.tabBarController setSelectedIndex:0];
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
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = [self currentPage];
    self.pageControl.hidden = [self currentPage] == self.pageControl.numberOfPages;
    self.sendButton.hidden = self.pageControl.currentPage != self.pageControl.numberOfPages - 1;
}

#pragma mark - Private

- (void)openPage:(NSInteger)page {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width*page, self.scrollView.contentOffset.y);
    }];
}

- (void)showSimpleModalWithMessage:(NSString*)message {
    [self showModalViewControllerWithIdentifier:@"SimpleModalVC" setupBlock:^(ModalViewController *modal) {
        SimpleModalVC *vc = (SimpleModalVC*)modal;
        vc.modalMessage = message;
        vc.closed = ^{
        };
        
    }];
}

- (void)prepareAppearance {
    
    self.finishFormTitles = @[NSLocalizedString(@"form.finish.titles.building.type", nil),
                              NSLocalizedString(@"form.finish.titles.floor.type", nil),
                              NSLocalizedString(@"form.finish.titles.roof.type", nil),
                              NSLocalizedString(@"form.finish.titles.basement.type", nil),
                              NSLocalizedString(@"form.finish.titles.wall.type", nil),
                              NSLocalizedString(@"form.finish.titles.roof.config", nil),
                              NSLocalizedString(@"form.finish.titles.slabs.material.type", nil),
                              NSLocalizedString(@"form.finish.titles.square.type", nil),];
    for (UIButton *button in self.buttons) {
        button.layer.cornerRadius = 15;
        button.backgroundColor = [UIColor app_mainColor];
        button.tintColor = [UIColor app_secondColor];
    }
    self.sendButton.backgroundColor = [UIColor app_mainColor];
    
    for (NSInteger i = 0; i < self.checkedImages.count; i++) {
        UIImageView *imageView = self.checkedImages[i];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCheckedImage:)];
        [imageView addGestureRecognizer:recognizer];
    }
    
    self.finishFormTitleLabel.text = NSLocalizedString(@"form.finish.notReady.title", nil);
    
    [self prepareHeaderStackForSize:self.view.frame.size];
}

- (void)prepareHeaderStackForSize:(CGSize)size {
    if (IS_IPHONE) {
        self.headerCheckStackViewHeight.constant = 20;
    } else {
        if (size.width < 460) {
            self.headerCheckStackViewHeight.constant = 20;
        } else {
            self.headerCheckStackViewHeight.constant = 40;
        }
    }
    [self.view layoutIfNeeded];
}
- (void)prepareImages {
    for (UIImageView *imageView in self.images) {
        imageView.image = [UIImage imageNamed:@"form-background"];
    }
}
- (NSInteger)currentPage {
    return self.scrollView.contentOffset.x / self.view.frame.size.width;
}
@end
