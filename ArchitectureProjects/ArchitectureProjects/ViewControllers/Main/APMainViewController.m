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

@interface APMainViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation APMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"APProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APProjectCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell updateCellWithImages:@[[NSURL URLWithString:@"https://im0-tub-by.yandex.net/i?id=e15fa858dc28449c65cfe685e091c972&n=33&h=215&w=344"],[NSURL URLWithString:@"https://im0-tub-by.yandex.net/i?id=d216507ad465ea810f559ac068c891b3&n=33&h=215&w=287"],[NSURL URLWithString:@"https://im0-tub-by.yandex.net/i?id=0bc393d81659483133860b96064632df&n=33&h=215&w=382"],[NSURL URLWithString:@"https://im0-tub-by.yandex.net/i?id=0bc393d81659483133860b96064632df&n=33&h=215&w=382"]]];
    return cell;
}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat picDimension = collectionView.frame.size.width / CELL_SIZE_COEF;
    return CGSizeMake(picDimension, picDimension);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    float sectionInset = 0;
    return UIEdgeInsetsMake(0,sectionInset, 0, sectionInset);
}

@end
