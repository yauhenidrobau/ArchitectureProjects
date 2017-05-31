//
//  Utils.m
//  BelarusNews
//
//  Created by YAUHENI DROBAU on 09/01/2017.
//  Copyright © 2017 YAUHENI DROBAU. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(void)addShadowToView:(UIView*)view {
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor blueColor].CGColor;
}

@end
