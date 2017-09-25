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
#import <QuartzCore/QuartzCore.h>
#import "Canvas.h"

@interface APProjectCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage1;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage2;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage3;
@property (weak, nonatomic) IBOutlet CSAnimationView *view;
@property (strong, nonatomic) NSArray *images;

@end

@implementation APProjectCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.images = @[self.mainImage, self.smallImage1,self.smallImage2, self.smallImage3];
    self.layer.cornerRadius = 15;
    
    self.view.backgroundColor = [UIColor clearColor];

//    
//    self.view.duration = 0.5;
//    self.view.delay    = 0;
//    self.view.type     = CSAnimationTypeMorph;
    
}

-(void)updateCellWithProject:(APProjectObject *)project {
    [self.view startCanvasAnimation];
    for (NSInteger i = 0; i < self.images.count; i++) {
        
        
        [((UIImageView*)self.images[i]) sd_setImageWithURL:[NSURL URLWithString:project.images[i].image]];
//        ((UIImageView*)self.images[i]).image = [self maskImage:((UIImageView*)self.images[i]).image];
//                ((UIImageView*)self.images[i]).image = [UIImage imageNamed:@"squircle-full-icon"];
    }
}

- (UIImage*) maskImage:(UIImage *)image {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIImage *maskImage = [UIImage imageNamed:@"squircle-full-icon"];
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

@end
