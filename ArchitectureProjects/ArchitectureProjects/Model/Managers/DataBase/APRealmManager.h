//
//  APRealmManager.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APUser.h"
#import "Macros.h"

@interface APRealmManager : NSObject

+(instancetype)sharedInstance;

- (void)saveUserWithEmail:(NSString*)email withCallback:(RealmDataManagerSaveCallback)callback;
- (APUser*)getUser;

- (void)saveToProject:(NSDictionary*)projectDict withCallback:(RealmDataManagerSaveCallback)callback;

- (NSArray*)RLMResultsToArray:(RLMResults *)results;
- (NSArray*)projectImagesRLMResultsToArray:(RLMResults *)results;

@end
