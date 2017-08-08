//
//  APProjectCollectionViewCell.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APProjectObject.h"

@interface APProjectCollectionViewCell : UICollectionViewCell

-(void)updateCellWithProject:(APProjectObject*)project;

@end