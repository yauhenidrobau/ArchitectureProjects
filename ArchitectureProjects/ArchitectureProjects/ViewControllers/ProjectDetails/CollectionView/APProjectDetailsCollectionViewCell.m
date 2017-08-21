//
//  APProjectDetailsCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectDetailsCollectionViewCell.h"

#import <UIImageView+WebCache.h>
#import "APProjectObject.h"

@interface APProjectDetailsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end

@implementation APProjectDetailsCollectionViewCell


- (void)setImageURL:(NSURL *)imageURL {
    [self.cellImage sd_setImageWithURL:imageURL];
    _imageURL = imageURL;
    
}

@end
