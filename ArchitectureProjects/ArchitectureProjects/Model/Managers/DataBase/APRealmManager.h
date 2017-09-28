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
- (APUser*)getUser;

- (void)saveUserImage:(UIImage*)image;
- (NSArray*)getUserImages;

- (void)saveToProject:(NSDictionary*)projectDict withCallback:(RealmDataManagerSaveCallback)callback;

- (void)removeItem:(id)item;
- (void)removeAllItemsForClass:(NSString*)className;

- (NSArray*)RLMResultsToArray:(RLMResults *)results;
- (NSArray*)projectImagesRLMResultsToArray:(RLMResults *)results;
- (NSArray*)RLMResultsToArray:(RLMResults *)results withSortDescriptor:(NSString*)descriptor;

@end
