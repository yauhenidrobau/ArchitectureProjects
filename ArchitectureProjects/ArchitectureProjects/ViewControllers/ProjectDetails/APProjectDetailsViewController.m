//
//  APProjectDetailsViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/18/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectDetailsViewController.h"

#import "APProjectDetailsTableViewCell.h"
#import "APProjectDetailsCollectionViewCell.h"
#import "APFileHelper.h"
#import "APConstants.h"

@interface APProjectDetailsViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation APProjectDetailsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"APProjectDetailsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projectObject.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APProjectDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCell" forIndexPath:indexPath];
    cell.imageURL = [APFileHelper getImagePath:self.projectObject.name forImageIndex:indexPath.row+1];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat picDimension = collectionView.frame.size.width / CELL_SIZE_COEF - 10;
//    return CGSizeMake(picDimension, picDimension);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    float sectionInset = 0;
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
@end
