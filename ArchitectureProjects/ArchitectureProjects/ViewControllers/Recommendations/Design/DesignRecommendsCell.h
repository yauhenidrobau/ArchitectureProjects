//
//  DesignRecommendsCell.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/28/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignObject;

@interface DesignRecommendsCell : UITableViewCell

- (void)updateWithRecommendation:(DesignObject *)recommendation;
@end
