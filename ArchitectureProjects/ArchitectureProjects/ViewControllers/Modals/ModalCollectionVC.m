//
//  ModalCollectionVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "ModalCollectionVC.h"
#import "APModalCollectionViewCell.h"
#import "APFileHelper.h"
#import "APConstants.h"

@interface ModalCollectionVC () < UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *imagesCountLabel;
@property (nonatomic) NSInteger currentPage;
@end

@implementation ModalCollectionVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"APModalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"APModalCollectionViewCell"];
    self.imagesCountLabel.text = [NSString stringWithFormat:@"%d %@ %lu",1, NSLocalizedString(@"of", nil), self.projectObject.images.count];

}

#pragma mark IBAction
- (IBAction)closeButtonPressed:(id)sender {
    self.closeButtonTappedBlock();
}
- (IBAction)shareButtonPresed:(id)sender {
    APModalCollectionViewCell *cell = self.collectionView.visibleCells.firstObject;
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[cell.image] applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projectObject.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APModalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APModalCollectionViewCell" forIndexPath:indexPath];
    cell.imageURL = [NSURL URLWithString:((APImagesObject *)self.projectObject.images[indexPath.row]).image];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.closeButtonTappedBlock();
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    float pageWidth = self.collectionView.frame.size.width+5; // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset >= currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset , scrollView.contentOffset.y) animated:YES];
    int index = newTargetOffset / pageWidth;
    self.imagesCountLabel.text = [NSString stringWithFormat:@"%d %@ %ld",index+1, NSLocalizedString(@"of", nil), self.projectObject.images.count];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

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
