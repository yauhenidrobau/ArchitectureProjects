//
//  APCostViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APCostViewController.h"

@interface APCostViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;

@end

@implementation APCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tutorialButton.layer.cornerRadius = 15;
    self.tutorialButton.layer.borderWidth = 1;
    self.tutorialButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
