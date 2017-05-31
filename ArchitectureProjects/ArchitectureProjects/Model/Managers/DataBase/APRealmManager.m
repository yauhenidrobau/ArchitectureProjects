//
//  APRealmManager.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APRealmManager.h"

#import <Realm.h>
#import "APProjectObject.h"
#import "APImagesObject.h"

@implementation APRealmManager
SINGLETON(APRealmManager)

#pragma mark - Public

#pragma mark - User

- (void)saveUserWithEmail:(NSString*)email withCallback:(RealmDataManagerSaveCallback)callback {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    @try {
        APUser *user = [self RLMResultsToArray:[APUser objectsWhere:@"email == %@", email]].firstObject;
        if (!user) {
            user = [APUser new];
        }
        user.email = email;
        [realm addOrUpdateObject:user];
        [realm commitWriteTransaction];
        
        if (callback) {
            callback(nil);
        }
    } @catch (NSException *exception) {
        NSLog(@"exception");
        NSError *error = [NSError errorWithDomain:@"user save Error" code:-111 userInfo:nil];
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
        if (callback) {
            callback(error);
        }
    }
}

- (APUser*)getUser {
    return [APUser allObjects].firstObject;
}

#pragma mark - Project 

- (void)saveToProject:(NSDictionary*)projectDict withCallback:(RealmDataManagerSaveCallback)callback {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for (NSDictionary *project in projectDict.allValues) {
        [realm beginWriteTransaction];
        @try {
            NSString *projectId = project[@"id"] ;
            APProjectObject *projectObject = [self RLMResultsToArray:[APProjectObject objectsWhere:@"projectId == %@", projectId]].firstObject;
            if (!projectObject) {
                projectObject = [APProjectObject new];
                projectObject.projectId = [project[@"id"] integerValue];
                projectObject.name = project[@"name"];
                projectObject.category = project[@"category"];
                NSInteger index = 0;
                for (NSString *imageURL in [project[@"images"] allValues]) {
                    
                    APImagesObject  *imageObject = [[APImagesObject alloc] init];
                    imageObject.image = imageURL;
                    imageObject.imageID = index;
                    [projectObject.images  addObject:imageObject];
                    index ++;
                }
            }
            [realm addOrUpdateObject:projectObject];
            [realm commitWriteTransaction];
        } @catch (NSException *exception) {
            NSLog(@"exception");
            NSError *error = [NSError errorWithDomain:@"projectObject save Error" code:-111 userInfo:nil];
            if ([realm inWriteTransaction]) {
                [realm cancelWriteTransaction];
            }
            if (callback) {
                callback(error);
            }
        }
    }
    if (callback) {
        callback(nil);
    }
}

#pragma mark - Common

- (NSArray*)RLMResultsToArray:(RLMResults *)results {
    
    NSMutableArray *array = [NSMutableArray array];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    NSSortDescriptor * newSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"projectId" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:newSortDescriptor];
    array = [NSMutableArray arrayWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    return array;
}

- (NSArray*)projectImagesRLMResultsToArray:(RLMResults *)results {
    
    NSMutableArray *array = [NSMutableArray array];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    NSSortDescriptor * newSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"imageID" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:newSortDescriptor];
    array = [NSMutableArray arrayWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    return array;
}
@end
