//
//  CustomButton.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/25/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "CustomButton.h"

#define TITLE_INSET 8.f
#define IMAGE_INSETS UIEdgeInsetsMake(0, 30, 0, 30)

@implementation CustomButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundImage:[[UIImage imageNamed:@"drawer_btn_active"]resizableImageWithCapInsets:IMAGE_INSETS] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"drawer_btn_inactive"]resizableImageWithCapInsets:IMAGE_INSETS] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[[UIImage imageNamed:@"drawer_btn_inactive"]resizableImageWithCapInsets:IMAGE_INSETS] forState:UIControlStateSelected];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.f, TITLE_INSET, 0.f, TITLE_INSET)];
    self.titleLabel.lineBreakMode = NSLineBreakByClipping;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
    [self layoutSubviews];
}

- (CGSize)intrinsicContentSize {
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat titleWidth = CGRectGetWidth(self.titleLabel.frame) + 2*TITLE_INSET;
    return CGSizeMake((selfWidth > titleWidth ? selfWidth : titleWidth),CGRectGetHeight(self.frame));
}


@end
