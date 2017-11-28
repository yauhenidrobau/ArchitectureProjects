//
//  BuildingRecommendsCell.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/17/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendationObject.h"

@interface BuildingRecommendsCell : UITableViewCell

- (void)updateWithRecommendation:(RecommendationObject*)recommendation;
@end
