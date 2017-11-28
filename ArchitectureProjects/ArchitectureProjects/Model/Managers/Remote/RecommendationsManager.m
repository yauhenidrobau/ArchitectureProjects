//
//  RecommendationsManager.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/17/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "RecommendationsManager.h"

#import <Firebase.h>
#import "Macros.h"
#import "APNetworkHelper.h"
#import "APRealmManager.h"
#import "APProjectObject.h"
#import "APKeychainManager.h"
#import "APDownloadHelper.h"
#import "RecommendationObject.h"
#import "DesignObject.h"

@interface RecommendationsManager ()
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation RecommendationsManager

SINGLETON(RecommendationsManager)



#pragma mark - Public

- (void)loadBuildingRecommendationsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion {
    if ([APNetworkHelper isInternetConnected]) {
        self.ref = [[FIRDatabase database] reference];
        NSString *email = [APKeychainManager sharedInstance].storedEmail;
        NSLog(@"----- Login in Firebase -----");
        
        [[FIRAuth auth] signInWithEmail:email password:email completion:^(FIRUser *user, NSError *error) {
            if (user && !error) {
                NSLog(@"----- Get recommendations -----");
                
                [[self.ref child:@"recommendations"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    // Get user value
                    NSDictionary *recommendationsDict = [self parseObjectsFromJSON:snapshot];
                    NSLog(@"----- Save recommendations -----");
                    [[APRealmManager sharedInstance]saveToRecommendations:recommendationsDict[@"building"] withCallback:^(NSError *error) {
                        NSArray* cachedRecommendations = [self cachedRecommendations];
                        if (completion) {
                            completion(cachedRecommendations, YES, error);
                        }
                    }];
                } withCancelBlock:^(NSError * _Nonnull error) {
                    NSLog(@"%@", error.localizedDescription);
                    if (completion) {
                        completion([self cachedRecommendations], YES, error);
                    }
                }];
            } else {
                if (completion) {
                    completion([self cachedRecommendations], YES, error);
                }
            }
        }];
    }
}

- (void)loadDesignRecommendationsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion {
    if ([APNetworkHelper isInternetConnected]) {
        self.ref = [[FIRDatabase database] reference];
        NSString *email = [APKeychainManager sharedInstance].storedEmail;
        NSLog(@"----- Login in Firebase -----");
        
        [[FIRAuth auth] signInWithEmail:email password:email completion:^(FIRUser *user, NSError *error) {
            if (user && !error) {
                NSLog(@"----- Get recommendations -----");
                
                [[self.ref child:@"recommendations"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    // Get user value
                    NSDictionary *recommendationsDict = [self parseObjectsFromJSON:snapshot];
                    NSLog(@"----- Save recommendations -----");
                    [[APRealmManager sharedInstance]saveToDesignRecommendations:recommendationsDict[@"design"] withCallback:^(NSError *error) {
                        NSArray* cachedRecommendations = [self cachedDesignRecommendations];
                        if (completion) {
                            completion(cachedRecommendations, YES, error);
                        }
                    }];
                } withCancelBlock:^(NSError * _Nonnull error) {
                    NSLog(@"%@", error.localizedDescription);
                    if (completion) {
                        completion([self cachedRecommendations], YES, error);
                    }
                }];
            } else {
                if (completion) {
                    completion([self cachedRecommendations], YES, error);
                }
            }
        }];
    }
}

//- (NSArray*)loadProjectsForCategory:(NSString*)category {
//    return [[PLRealmManager instance]loadShopsForCategory:category];
//}
//
//- (NSArray*)loadCategories {
//    return [[PLRealmManager instance] loadShopCategories];
//}

#pragma mark - Private

#warning Background thread?!
- (NSArray*)cachedRecommendations {
    RLMResults *results = [RecommendationObject allObjects];
    NSArray *localObjects = [[APRealmManager sharedInstance] RLMResultsToArray:results withSortDescriptor:@"name"];
    return localObjects;
}

- (NSArray*)cachedDesignRecommendations {
    RLMResults *results = [DesignObject allObjects];
    NSArray *localObjects = [[APRealmManager sharedInstance] RLMResultsToArray:results withSortDescriptor:@"category"];
    return localObjects;
}

- (NSDictionary*)parseObjectsFromJSON:(FIRDataSnapshot *)JSON {
    NSError *error = nil;
    NSDictionary *recommendations = [JSON valueInExportFormat];
    if (error) {
        NSLog(@"Error reading file: %@",error.localizedDescription);
        return @{};
    } else {
        return  recommendations;
    }
}
@end
