//
//  UIColor+App.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "UIColor+App.h"
#import "Macros.h"

@implementation UIColor (App)

+ (UIColor*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
}

+(UIColor*)appColor {
    return RGB(28, 156, 125);
}

+(UIColor*)ap_darkBlueColor {
    return RGB(46, 136, 188);
}
@end
