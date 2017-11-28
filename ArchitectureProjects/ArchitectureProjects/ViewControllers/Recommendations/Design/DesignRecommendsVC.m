//
//  DesignRecommendsVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/20/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "DesignRecommendsVC.h"

#import "DesignRecommendsCell.h"
#import "APUserManager.h"
#import "Utils.h"
#import <SVProgressHUD.h>
#import "RecommendationsManager.h"
#import "APNetworkHelper.h"
#import "DesignObject.h"
#import "APRealmManager.h"

@interface DesignRecommendsVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *recommendations;

@end

@implementation DesignRecommendsVC

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareAppearance];
    
    [self loadData];
}

#pragma mark --
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell updateWithRecommendation:self.recommendations[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendations.count;
}

#pragma mark - Private
- (void)prepareAppearance {
    [self.tableView registerNib:[UINib nibWithNibName:@"DesignRecommendsCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.estimatedRowHeight = 150;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    self.recommendations = [[RecommendationsManager sharedInstance] cachedDesignRecommendations];
    [self.tableView reloadData];
    if ([Utils isInternetConnectionAvailable]) {
        //        [SVProgressHUD show];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //    STRONG(self);
        WEAK(self)
        
        [[RecommendationsManager sharedInstance] loadDesignRecommendationsWithCompletion:^(NSArray *objects, BOOL finished, NSError *error) {
            //    STRONG(self);
            if (finished && [APNetworkHelper isInternetConnected]) {
                self.recommendations = objects;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //      STRONG(self)
                    [self.tableView reloadData];
                    //                    [SVProgressHUD showSuccessWithStatus:@"Loaded"];
                    //                    [SVProgressHUD dismissWithDelay:0.5];
                });
            } else if (![APNetworkHelper isInternetConnected]){
                [[NSNotificationCenter defaultCenter]postNotificationName:NN_NETWORK_STATE_OFFLINE object:nil];
            }
        }];
    });
}

@end
