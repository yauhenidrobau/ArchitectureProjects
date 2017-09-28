//
//  PictureCollectionViewCell.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PictureCollectionViewCell;
@class UserImage;

@protocol PictureCollectionViewCellDelegate

- (void)cellDidRemoveItem:(UserImage*)item forIndexPath:(NSIndexPath*)indexPath;
@end

@interface PictureCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSIndexPath *indexpath;

- (void)updateCellWithImage:(UserImage*)image;

@property (weak, nonatomic) id<PictureCollectionViewCellDelegate> cellDelegate;

@end
