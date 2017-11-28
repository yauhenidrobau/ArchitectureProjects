//
//  FormCell.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormCell : UITableViewCell

- (void)updateCellWithTitle:(NSString*)title andValue:(NSString*)value;

@end
