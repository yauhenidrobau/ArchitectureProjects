//
//  APRealmManager.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "APUser.h"
#import "Macros.h"

@interface APRealmManager : NSObject

+(instancetype)sharedInstance;

- (void)saveUserWithEmail:(NSString*)email withCallback:(RealmDataManagerSaveCallback)callback;
- (void)getUserWithCallback:(RealmDataManagerGetobjectCallback)callback;
- (void)getProjectsWithCallback:(RealmDataManagerGetobjectsCallback)callback;

- (void)saveUserImage:(UIImage*)image;
- (void)getUserImagesWithCallback:(RealmDataManagerGetobjectsCallback)callback;

- (void)saveToProject:(NSDictionary*)projectDict withCallback:(RealmDataManagerSaveCallback)callback;
- (void)saveToRecommendations:(NSDictionary*)recommendationsDict withCallback:(RealmDataManagerSaveCallback)callback;
- (void)saveToDesignRecommendations:(NSDictionary*)recommendationsDict withCallback:(RealmDataManagerSaveCallback)callback;

- (void)removeItem:(id)item;
- (void)removeAllItemsForClass:(NSString*)className;

- (void)cachedRecommendationsWithCallback:(RealmDataManagerGetobjectsCallback)callback;
- (void)cachedDesignRecommendationsWithCallback:(RealmDataManagerGetobjectsCallback)callback;
- (void)cachedObjectsWithCallback:(RealmDataManagerGetobjectsCallback)callback;

- (NSArray*)RLMResultsToArray:(RLMResults *)results;
- (NSArray*)projectImagesRLMResultsToArray:(RLMResults *)results;
- (NSArray*)RLMResultsToArray:(RLMResults *)results withSortDescriptor:(NSString*)descriptor;

@end
