//
//  APModalCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APModalCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface APModalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end

@implementation APModalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIImage*)image {
    return self.cellImage.image;
}
- (void)setImageURL:(NSURL *)imageURL {
    [self.cellImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"no_image_200_200"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    _imageURL = imageURL;
    
}
@end
