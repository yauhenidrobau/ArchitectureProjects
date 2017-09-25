//
//  UIImageView+Rotation.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/25/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "UIImageView+Rotation.h"

@implementation UIImageView (Rotation)

- (void)rotateOnAngle:(CGFloat)angle animated:(BOOL)animated {
    [UIView beginAnimations:nil context:nil]; [UIView setAnimationDuration:(animated ? 0.3f : 0.f)]; [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeRotation(angle);
    [UIView commitAnimations];
}
@end
