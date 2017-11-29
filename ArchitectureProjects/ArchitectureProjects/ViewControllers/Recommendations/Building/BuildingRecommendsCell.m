//
//  BuildingRecommendsCell.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/17/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "BuildingRecommendsCell.h"

@interface BuildingRecommendsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BuildingRecommendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithRecommendation:(RecommendationObject *)recommendation {
    self.titleLabel.text = recommendation.name;
}

@end
