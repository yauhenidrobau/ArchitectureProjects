//
//  DesignRecommendsCell.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/28/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "DesignRecommendsCell.h"
#import "DesignObject.h"

@interface DesignRecommendsCell()

@property (weak, nonatomic) IBOutlet UILabel *celldescrLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCategoryLabel;


@end

@implementation DesignRecommendsCell

#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public
- (void)updateWithRecommendation:(DesignObject *)recommendation {
    self.celldescrLabel.text = recommendation.fullDescription;
    self.cellCategoryLabel.text = recommendation.category;

}
@end
