//
//  BuildingRecommendationsVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/16/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "BuildingRecommendationsVC.h"
#import "BuildingRecommendsCell.h"
#import "APUserManager.h"
#import "Utils.h"
#import <SVProgressHUD.h>
#import "RecommendationsManager.h"
#import "APNetworkHelper.h"
#import "RecommendationObject.h"
#import "APRealmManager.h"

@interface BuildingRecommendationsVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *recLabel;

@property (nonatomic) NSArray *recommendations;

@end

@implementation BuildingRecommendationsVC

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareAppearance];

    [self loadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuildingRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell updateWithRecommendation:self.recommendations[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  176.0;
}

#pragma mark - Private
- (void)prepareAppearance {
    [self.tableView registerNib:[UINib nibWithNibName:@"BuildingRecommendsCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

-(void)loadData {
    if ([APUserManager sharedInstance].isUserAuthorised) {
        [self loadProjects];
    } else {
        [[APUserManager sharedInstance] loginUserWithEmail:@"test@test.com" withCompletion:^(NSError *error) {
            [self loadProjects];
        }];
    }
}

-(void)loadProjects {
    
    self.recommendations = [[RecommendationsManager sharedInstance] cachedRecommendations];
    self.recLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Recommendations: %d",nil),self.recommendations.count];
    [self.tableView reloadData];
    if ([Utils isInternetConnectionAvailable]) {
        [SVProgressHUD show];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    //    STRONG(self);
        WEAK(self)

        [[RecommendationsManager sharedInstance] loadBuildingRecommendationsWithCompletion:^(NSArray *objects, BOOL finished, NSError *error) {
        //    STRONG(self);
            if (finished && [APNetworkHelper isInternetConnected]) {
                self.recommendations = objects;
                self.recLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Recommendations: %d",nil),self.recommendations.count];
                dispatch_async(dispatch_get_main_queue(), ^{
              //      STRONG(self)
                    [self.tableView reloadData];
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"common.loaded", nil)];
                    [SVProgressHUD dismissWithDelay:0.5];
                });
            } else if (![APNetworkHelper isInternetConnected]){
                [[NSNotificationCenter defaultCenter]postNotificationName:NN_NETWORK_STATE_OFFLINE object:nil];
            }
        }];
    });
}
@end
