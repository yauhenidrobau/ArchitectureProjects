//
//  Utils.m
//  BelarusNews
//
//  Created by YAUHENI DROBAU on 09/01/2017.
//  Copyright © 2017 YAUHENI DROBAU. All rights reserved.
//

#import "Utils.h"
#import "APImagesObject.h"
#import "APProjectObject.h"
#import "APImage.h"
#import "UIImageView+WebCache.h"
#import "APRealmManager.h"
#import "AppDelegate.h"

@implementation Utils

+(void)addShadowToView:(UIView*)view {
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor blueColor].CGColor;
}

+(NSArray*)imagesFromImagesObject:(APProjectObject *)object {
    NSMutableArray *images = [@[] mutableCopy];
    
    for (APImagesObject *imageObject in object.images) {
        APImage *image = [APImage new];
        UIImageView * imageView = [UIImageView new];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageObject.image]];
        image.image = imageView.image;
        image.imageData = imageObject.imageData;
        image.attributedCaptionTitle = [[NSAttributedString alloc]initWithString:imageObject.captionTitle];
        image.attributedCaptionCredit = [[NSAttributedString alloc]initWithString:imageObject.captionCredit];
        image.attributedCaptionSummary = [[NSAttributedString alloc]initWithString:imageObject.captionSummary];

        [images addObject:image];
    }
    return images;
}

+(BOOL)isInternetConnectionAvailable {
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).reachability.currentReachabilityStatus != GCNetworkReachabilityStatusNotReachable;
}
@end
