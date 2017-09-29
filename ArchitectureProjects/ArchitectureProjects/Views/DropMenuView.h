//
//  DropMenuView.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/25/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    FilterFloorOption = 1,
    FilterAreaOption = 2,
    FilterGarageOption = 3,
}FilterOptions;

@class DropMenuView;
@protocol DropMenuDelegate <NSObject>

- (void)changeMenuYPosition:(CGFloat)newY animated:(BOOL)animated;
- (void)filterTouched:(NSDictionary*)settings;

@end

@interface DropMenuView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuTopSpace;
@property (nonatomic) CGFloat superTopConstant;

@property (weak, nonatomic) id <DropMenuDelegate>delegate;


@end
