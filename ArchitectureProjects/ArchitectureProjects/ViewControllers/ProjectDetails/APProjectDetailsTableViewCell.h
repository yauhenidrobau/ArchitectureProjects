//
//  APProjectDetailsTableViewCell.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/18/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "APProjectObject.h"

@interface APProjectDetailsTableViewCell : UITableViewCell

-(void)updateCellWithProject:(APProjectObject*)project;

@end
