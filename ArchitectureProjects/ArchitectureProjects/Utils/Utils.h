//
//  Utils.h
//  BelarusNews
//
//  Created by YAUHENI DROBAU on 09/01/2017.
//  Copyright © 2017 YAUHENI DROBAU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class APProjectObject;

@interface Utils : NSObject

+(void)addShadowToView:(UIView*)view;
+(NSArray*)imagesFromImagesObject:(APProjectObject*)object;
+(BOOL)isInternetConnectionAvailable;
+ (CGFloat)deviceKoeff;
+ (NSString *)mimeTypeForData:(NSData *)data;

+(BOOL)firstimage:(UIImage *)image1 isEqualTo:(UIImage *)image2;
@end
