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
#import "Macros.h"

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

+(BOOL)firstimage:(UIImage *)image1 isEqualTo:(UIImage *)image2 {
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqualToData:data2];
}

+ (CGFloat)deviceKoeff {
    if (IS_IPHONE_4_OR_LESS) {
        return 0.9;
    }
    else if (IS_IPHONE_5) {
        return 0.9;
    }
    else if (IS_IPHONE_6) {
        return 1;
    }
    else if (IS_IPHONE_6P) {
        return 1.1;
    }
    else if (IS_IPAD){
        return 2;
    } else {
        return 1;
    }
}

+ (NSString *)mimeTypeForData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
            break;
        case 0x89:
            return @"image/png";
            break;
        case 0x47:
            return @"image/gif";
            break;
        case 0x49:
        case 0x4D:
            return @"image/tiff";
            break;
        case 0x25:
            return @"application/pdf";
            break;
        case 0xD0:
            return @"application/vnd";
            break;
        case 0x46:
            return @"text/plain";
            break;
        default:
            return @"application/octet-stream";
    }
    return nil;
}

+(BOOL)isInternetConnectionAvailable {
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).reachability.currentReachabilityStatus != GCNetworkReachabilityStatusNotReachable;
}
@end
