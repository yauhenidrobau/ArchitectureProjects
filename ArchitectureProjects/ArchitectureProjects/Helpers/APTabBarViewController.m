//
//  APTabBarViewController.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/1/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APTabBarViewController.h"

@interface APTabBarViewController ()

@end

@implementation APTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tabBar.items[0] setTitle:NSLocalizedString(@"Projects", nil)];
    [self.tabBar.items[1] setTitle:NSLocalizedString(@"Projects", nil)];
    [self.tabBar.items[2] setTitle:NSLocalizedString(@"Projects", nil)];
    [self.tabBar.items[3] setTitle:NSLocalizedString(@"Projects", nil)];
    [self.tabBar.items[4] setTitle:NSLocalizedString(@"Map", nil)];
    self.tabBar.tintColor = [UIColor redColor];

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
