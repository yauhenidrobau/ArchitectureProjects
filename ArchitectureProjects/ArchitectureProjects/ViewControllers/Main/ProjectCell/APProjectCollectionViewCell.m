//
//  APProjectCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@interface APProjectCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage1;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage2;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage3;
@property (strong, nonatomic) NSArray *images;

@end

@implementation APProjectCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.images = @[self.mainImage, self.smallImage1,self.smallImage2, self.smallImage3];
}

-(void)updateCellWithImages:(NSArray *)imagesURL {
    for (NSInteger i = 0; i < self.images.count; i++) {
        [((UIImageView*)self.images[i]) sd_setImageWithURL:imagesURL[i]];
    }
    
}
@end
