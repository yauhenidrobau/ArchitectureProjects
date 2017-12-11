//
//  SimpleModalTextFiledsWithCollectionVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 12/8/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "SimpleModalTextFiledsWithCollectionVC.h"

#import "UIColor+App.h"
#import <Canvas/Canvas.h>
#import "ProjectsDataSource.h"
#import "Macros.h"
#import "APProjectObject.h"
#import "APRealmManager.h"
#import "APProjectCollectionViewCell.h"
#import "UIViewController+ShowModal.h"

@interface SimpleModalTextFiledsWithCollectionVC () <UITextFieldDelegate, UICollectionViewDelegateFlowLayout >

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UITextField *projectNumber;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSArray *projects;

@property (strong, nonatomic) ProjectsDataSource *projectsDataSource;
@end

@implementation SimpleModalTextFiledsWithCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.textColor = [UIColor app_secondColor];
    self.projectTitleLabel.textColor = [UIColor app_secondColor];
    
    [self.okButton setTitleColor:[UIColor app_secondColor] forState:UIControlStateNormal];
    [self.okButton setTitle:NSLocalizedString(@"common.send", nil) forState:UIControlStateNormal];
    
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
    
    self.projects = @[];
    [self prepareCollectionView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:recognizer];
    
    WEAK(self)
    [[APRealmManager sharedInstance] getProjectsWithCallback:^(NSArray *objects, NSError *error) {
        STRONG(self)
        self.projects = objects;
        [self.collectionView reloadData];
    }];
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projects.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APProjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell updateCellWithProject:self.projects[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat picDimension = collectionView.frame.size.width;
    if (!IS_IPHONE) {
        return CGSizeMake(collectionView.frame.size.width / 5 - 10, collectionView.frame.size.height);
    }
    return CGSizeMake(picDimension/2.2, picDimension/2.2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    float sectionInset = 5;
    return UIEdgeInsetsMake(0,sectionInset, 0, sectionInset);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

#pragma mark - IBActions

- (IBAction)okButtonTouched:(id)sender {
    [self closeByButton];
}

- (void)closeByButton {
//    if (self.phoneTF.text.length && self.addressTF.text.length && self.projectNumber.text.length) {
        if (self.closedWithData) {
            self.closedWithData(self.phoneTF.text, self.addressTF.text, self.projectNumber.text);
        }
        if (self.closeButtonTappedBlock) {
            self.closeButtonTappedBlock ();
        }
}

- (void)close {
    if (self.closeButtonTappedBlock) {
        self.closeButtonTappedBlock ();
    }
}

#pragma mark - Private
- (void)prepareCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"APProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    // Configure layout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    [self.flowLayout setItemSize:CGSizeMake(191, 160)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.minimumInteritemSpacing = 10.0f;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.bounces = YES;
}
@end

