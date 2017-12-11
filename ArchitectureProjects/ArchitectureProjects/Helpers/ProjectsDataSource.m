//
//  ProjectsDataSource.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 12/8/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "ProjectsDataSource.h"

#import "APProjectCollectionViewCell.h"
#import "APProjectManager.h"
#import "APRealmManager.h"
#import "APNetworkHelper.h"

@interface ProjectsDataSource() 

@property (strong, nonatomic) NSArray *projects;


@end

@implementation ProjectsDataSource

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projects.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APProjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell updateCellWithProject:self.projects[indexPath.row]];
    return cell;
}

#pragma mark - Public

-(void)loadProjects {
    
    [self startLoading];
    [[APProjectManager sharedInstance] loadProjectsWithCompletion:^(NSArray *projects, BOOL finished, NSError *error) {
        if (!finished) {
            self.projects = projects;
            [self reloadData];
        }
        if (finished && [APNetworkHelper isInternetConnected]) {
            self.projects = [[APRealmManager sharedInstance]RLMResultsToArray:[APProjectObject allObjects]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
                [self finishLoading];
            });
        } else if (![APNetworkHelper isInternetConnected]){
            [self finishLoading];
            [[NSNotificationCenter defaultCenter]postNotificationName:NN_NETWORK_STATE_OFFLINE object:nil];
        }
    }];
}

#pragma mark - Private
- (void)reloadData {
    if (self.reloadAction) {
        self.reloadAction();
    }
}

- (void)startLoading {
    if (self.startLoadingAction) {
        self.startLoadingAction();
    }
}

- (void)finishLoading {
    if (self.finishLoadingAction) {
        self.finishLoadingAction();
    }
}
@end
