//
//  UIImage+Smart.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/26/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Smart)

- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;

@end
