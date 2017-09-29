//
//  APMainViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APMainViewController.h"

#import "APProjectCollectionViewCell.h"
#import "APConstants.h"
#import "APProjectObject.h"
#import "APRealmManager.h"
#import "APKeychainManager.h"
#import "APUserManager.h"
#import "APProjectManager.h"
#import "Macros.h"
#import "APProjectDetailsViewController.h"
#import "APDownloadHelper.h"
#import "APUserManager.h"
#import "APNetworkHelper.h"
#import "Utils.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+ShowModal.h"
#import "ModalCollectionVC.h"
#import "DropMenuView.h"
#import "FilterTableViewController.h"

#define APMainViewControllerFilterSegue @"FilterSegue"
@interface APMainViewController () <UICollectionViewDelegate, UICollectionViewDataSource, DropMenuDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSArray *projects;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) APProjectCollectionViewCell *selectedCell;
@property (nonatomic) CGRect defaultCellFrame;
@property (nonatomic) CGFloat currentOffset;
@property (weak, nonatomic) IBOutlet DropMenuView *dropMenuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropMenuViewTopConstraint;

@end

@implementation APMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dropMenuView.delegate = self;
    self.dropMenuView.superTopConstant = self.dropMenuViewTopConstraint.constant;
    
    [self prepareCollectionView];
    [self prepareAppearance];
    
    [self.navigationController.navigationItem setTitle:@"Kee"];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - IBActions

-(void)pullToRefresh {
    [self loadProjects];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projects.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APProjectCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell updateCellWithProject:self.projects[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    APProjectObject *object = self.projects[indexPath.row];
//    NSArray *images = [Utils imagesFromImagesObject:object];
//    NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:images];
//    [self presentViewController:photosViewController animated:YES completion:nil];
    
    [UIView animateWithDuration:0.5  animations:^{
        [self showModalViewControllerWithIdentifier:@"ModalCollectionVC" setupBlock:^(ModalViewController *modal) {
            ModalCollectionVC *vc = (ModalCollectionVC*)modal;
            vc.projectObject = object;
        } animated:YES];
    } completion:^(BOOL finished) {
    }];

//    [self performSegueWithIdentifier:@"ProjectDetailSegue" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"ProjectDetailSegue"]) {
//       APProjectDetailsViewController *vc = segue.destinationViewController;
//        APProjectObject *object = self.projects[[self.collectionView indexPathForCell:sender].row];
//        vc.projectObject = object;
//    }
//}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat picDimension = collectionView.frame.size.width;
    if (!IS_IPHONE) {
        return CGSizeMake(collectionView.frame.size.width / 3 - 10, collectionView.frame.size.height / 3);
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

#pragma mark - ScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollView = self.collectionView;
    _currentOffset = self.collectionView.contentOffset.y;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    CGFloat scrollPos = self.collectionView.contentOffset.y ;
//    
//    if(scrollPos < 65 && self.navigationController.isNavigationBarHidden){
//        //Fully hide your toolbar
////            [UIView animateWithDuration:1 animations:^{
//                [self.navigationController setNavigationBarHidden:NO animated:YES];
////            }];
//    } else {
//        if (scrollPos > 65 && !self.navigationController.isNavigationBarHidden) {
//            //Slide it up incrementally, etc.
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//        }
//    }
}

#pragma mark - DropMenuDelegate
- (void)changeMenuYPosition:(CGFloat)newY animated:(BOOL)animated {
    [UIView animateWithDuration:(animated ? 0.3f : 0.f) delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.dropMenuViewTopConstraint.constant = newY;
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)filterTouched:(NSDictionary *)settings {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"garage = %@ AND (totalArea >= %@ AND totalArea <= %@) AND floors = %@", settings[@"garageSettings"], settings[@"areaMinValue"], settings[@"areaMaxValue"], settings[@"floorSettings"]];
    self.projects = [[[APRealmManager sharedInstance] RLMResultsToArray:[APProjectObject allObjects]] filteredArrayUsingPredicate:predicate];
    [self.collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber*)sender {
    if ([segue.identifier isEqualToString:APMainViewControllerFilterSegue]) {
        FilterTableViewController *vc = segue.destinationViewController;
        if (sender.integerValue == FilterFloorOption) {
            vc.filterArray = [[APRealmManager sharedInstance] RLMResultsToArray:[APProjectObject allObjects] withSortDescriptor:@"floors"];
        } else if (sender.integerValue == FilterAreaOption) {
            vc.filterArray = [[APRealmManager sharedInstance] RLMResultsToArray:[APProjectObject allObjects] withSortDescriptor:@"area"];
        }
    }
}
#pragma mark - Private

-(void)prepareCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"APProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    // Configure layout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [self.flowLayout setItemSize:CGSizeMake(191, 160)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 10.0f;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.bounces = YES;
}

-(void)prepareAppearance {

    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:self.view.frame];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    [self.collectionView addSubview:self.refreshControl];
}

-(void)loadData {
    WEAK(self)
    if ([APUserManager sharedInstance].isUserAuthorised) {
        [self loadProjects];
    } else {
        [[APUserManager sharedInstance] loginUserWithEmail:@"test@test.com" withCompletion:^(NSError *error) {
            STRONG(self)
            [self loadProjects];
        }];
    }
}

-(void)loadProjects {
    WEAK(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([Utils isInternetConnectionAvailable]) {
            [SVProgressHUD show];
        }
        [[APProjectManager sharedInstance] loadProjectsWithCompletion:^(NSArray *projects, BOOL finished, NSError *error) {
            STRONG(self)
//            self.projects = [[APRealmManager sharedInstance]RLMResultsToArray:[APProjectObject allObjects]];
//            [self.collectionView reloadData];
            if (finished && [APNetworkHelper isInternetConnected]) {
                self.projects = [[APRealmManager sharedInstance]RLMResultsToArray:[APProjectObject allObjects]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    [self.refreshControl endRefreshing];
                    [SVProgressHUD showSuccessWithStatus:@"Loaded"];
                    [SVProgressHUD dismissWithDelay:0.5];
                });
            } else if (![APNetworkHelper isInternetConnected]){
                [self.refreshControl endRefreshing];
                [[NSNotificationCenter defaultCenter]postNotificationName:NN_NETWORK_STATE_OFFLINE object:nil];
            }
        }];
    });

}
@end
