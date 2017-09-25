//
//  APImage.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 7/27/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APImage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) NSAttributedString *attributedCaptionTitle;
@property (nonatomic, strong) NSAttributedString *attributedCaptionSummary;
@property (nonatomic, strong) NSAttributedString *attributedCaptionCredit;

@end
