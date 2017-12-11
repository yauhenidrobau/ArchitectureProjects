//
//  FormCell.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "FormCell.h"

#import "Macros.h"
#import "FontHelper.h"
#import "Utils.h"
#import "UIColor+App.h"

@interface FormCell()

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellValueLabel;


@end

@implementation FormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cellTitleLabel.font = FONT(FTCochin,16*[Utils deviceKoeff]);
    self.cellValueLabel.font = FONT(FTCochin,16*[Utils deviceKoeff]);
    self.backgroundColor = [UIColor app_mainColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithTitle:(NSString *)title andValue:(NSString *)value {
    self.cellTitleLabel.text = title;
    self.cellValueLabel.text = value;
}

@end
