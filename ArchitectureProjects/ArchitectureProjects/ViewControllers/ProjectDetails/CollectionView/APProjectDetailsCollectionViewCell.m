//
//  APProjectDetailsCollectionViewCell.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectDetailsCollectionViewCell.h"

@interface APProjectDetailsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end

@implementation APProjectDetailsCollectionViewCell


- (void)setImageURL:(NSString *)imageURL {
    [self.cellImage setImage:[UIImage imageWithContentsOfFile:imageURL]];
    _imageURL = imageURL;
}

@end
