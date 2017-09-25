//
//  APTabBarViewController.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/1/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APTabBarViewController.h"

#import "Macros.h"
#import "UIColor+App.h"
#import "FontHelper.h"

@interface APTabBarViewController ()

@end

@implementation APTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tabBar.items[0] setTitle:NSLocalizedString(@"Projects", nil)];
    [self.tabBar.items[0] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: FONT(FTCochin, 12)} forState:UIControlStateNormal];
    
    [self.tabBar.items[1] setTitle:NSLocalizedString(@"Projects2", nil)];
    [self.tabBar.items[1] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: FONT(FTCochin, 12)} forState:UIControlStateNormal];

    [self.tabBar.items[2] setTitle:NSLocalizedString(@"Projects3", nil)];
    [self.tabBar.items[2] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: FONT(FTCochin, 12)} forState:UIControlStateNormal];

    [self.tabBar.items[3] setTitle:NSLocalizedString(@"Map", nil)];
    [self.tabBar.items[3] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: FONT(FTCochin, 12)} forState:UIControlStateNormal];

    [self.tabBar.items[4] setTitle:NSLocalizedString(@"Projects4", nil)];
    [self.tabBar.items[4] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: FONT(FTCochin, 12)} forState:UIControlStateNormal];

    self.tabBar.barTintColor = [UIColor ap_darkBlueColor];
    self.tabBar.tintColor = [UIColor whiteColor];

    if ([self.tabBar respondsToSelector:@selector(unselectedItemTintColor)]) {
        self.tabBar.unselectedItemTintColor = [UIColor whiteColor];
    } else {
        
    }
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
