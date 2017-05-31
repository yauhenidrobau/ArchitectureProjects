//
//  APProjectCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectCollectionViewCell.h"

#import <UIImageView+WebCache.h>
#import "APImagesObject.h"
#import "APFileHelper.h"

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

-(void)updateCellWithProject:(APProjectObject *)project {
    
    for (NSInteger i = 0; i < self.images.count; i++) {
        NSString *imagePath = [APFileHelper getImagePath:project.name forImageIndex:i+1];
        NSString *imageString = [[NSString alloc]initWithString:((APImagesObject*)project.images[i]).image];
        if (!imagePath.length) {
            NSURL *imageURL = [NSURL URLWithString:imageString];
            [((UIImageView*)self.images[i]) sd_setImageWithURL:imageURL];
        } else {
            [((UIImageView*)self.images[i]) setImage:[UIImage imageWithContentsOfFile:imagePath]];

        }
    }
}
@end
