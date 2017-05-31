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

@interface APMainViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSArray *projects;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation APMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareCollectionView];
    [self prepareAppearance];
    
    [self.navigationController.navigationItem setTitle:@"Kee"];
    
    [self loadData];
    
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
    APProjectCollectionViewCell *cell = (APProjectCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ProjectDetailSegue" sender:cell];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProjectDetailSegue"]) {
       APProjectDetailsViewController *vc = segue.destinationViewController;
        APProjectObject *object = self.projects[[self.collectionView indexPathForCell:sender].row];
        vc.projectObject = object;
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat picDimension = collectionView.frame.size.width;
    if (!IS_IPHONE) {
        return CGSizeMake(collectionView.frame.size.width / 3 - 40, collectionView.frame.size.height / 3);
    }
    return CGSizeMake(picDimension, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    float sectionInset = 20;
    return UIEdgeInsetsMake(0,sectionInset, 0, sectionInset);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
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

#pragma mark - Private

-(void)prepareCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"APProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    // Configure layout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [self.flowLayout setItemSize:CGSizeMake(191, 160)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 10.0f;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.bounces = YES;
}

-(void)prepareAppearance {

    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:self.view.frame];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    [self.collectionView addSubview:self.refreshControl];
    
}

-(void)loadData {
    WS()
    if ([APUserManager sharedInstance].isUserAuthorised) {
        [wself loadProjects];
    } else {
        [[APUserManager sharedInstance] loginUserWithEmail:@"test@test.com" withCompletion:^(NSError *error) {
            [wself loadProjects];
        }];
    }
}

-(void)loadProjects {
    WS()
    [[APProjectManager sharedInstance] loadProjectsWithCompletion:^(NSArray *projects, BOOL finished, NSError *error) {
        wself.projects = [[APRealmManager sharedInstance]RLMResultsToArray:[APProjectObject allObjects]];
        [wself.collectionView reloadData];

        if (finished && [APNetworkHelper isInternetConnected]) {
            NSLog(@"----- Download Images -----");
            [[APDownloadHelper sharedInstance]downloadImageForProjects:projects withCallback:^(BOOL downloaded, BOOL finished) {
                if (finished) {
                    wself.projects = [[APRealmManager sharedInstance]RLMResultsToArray:[APProjectObject allObjects]];
                    [wself.collectionView reloadData];
                    [wself.refreshControl endRefreshing];
                }
            }];
        } else if (![APNetworkHelper isInternetConnected]){
            [wself.refreshControl endRefreshing];
            [[NSNotificationCenter defaultCenter]postNotificationName:NN_NETWORK_STATE_OFFLINE object:nil];
        }
    }];
}
@end
