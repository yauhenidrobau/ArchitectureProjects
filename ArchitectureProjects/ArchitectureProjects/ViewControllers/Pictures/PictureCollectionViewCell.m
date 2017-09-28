//
//  PictureCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "UserImage.h"
#import "APRealmManager.h"

@interface PictureCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (strong, nonatomic) UserImage *currentImageObject;
@end

@implementation PictureCollectionViewCell

#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius = 15;
    
}

#pragma mark - IBActions

- (IBAction)deteleItemTouched:(id)sender {
    [self.cellDelegate cellDidRemoveItem:self.currentImageObject forIndexPath:self.indexpath];
}

#pragma mark - Public
- (void)updateCellWithImage:(UserImage*)image {
    self.currentImageObject = image;
    self.cellImage.image = [UIImage imageWithData:image.imageData];
}

@end
