//
//  RecommendationsManager.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/17/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendationsManager : NSObject

+(instancetype)sharedInstance;

- (void)loadBuildingRecommendationsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion;
- (void)loadDesignRecommendationsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion;
- (NSArray*)cachedRecommendations;
- (NSArray*)cachedDesignRecommendations;
@end
