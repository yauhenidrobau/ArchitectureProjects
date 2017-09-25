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
- (APUser *)getUser {
    return [APUser allObjects].firstObject;
}

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

#pragma mark - Project 

- (void)saveToProject:(NSDictionary*)projectDict withCallback:(RealmDataManagerSaveCallback)callback {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSInteger index = 0;
    NSLog(@"%@",[RLMRealm defaultRealm].configuration.fileURL);
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
                projectObject.floors = project[@"floors"];
                projectObject.totalArea = project[@"area"];
                projectObject.garage = [project[@"garage"] boolValue];
                for (NSString *imageURL in [project[@"images"] allValues]) {
                    
                    APImagesObject  *imageObject = [[APImagesObject alloc] init];
                    imageObject.image = imageURL;
                    imageObject.imagePrimaryID = index;
//                    imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                    imageObject.captionTitle = [NSString stringWithFormat:@"%@-captionTitle-%ld", projectObject.name, index];
                    imageObject.captionCredit = [NSString stringWithFormat:@"%@-captionCredit-%ld", projectObject.name, index];
                    imageObject.captionSummary = [NSString stringWithFormat:@"%@-captionSummary-%ld", projectObject.name, index];
                    
                    [projectObject.images  addObject:imageObject];
                    [realm addOrUpdateObject:projectObject];
                    index ++;
                }
            } else {
                [realm addOrUpdateObject:projectObject];
            }
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

- (NSArray*)RLMResultsToArray:(RLMResults *)results withSortDescriptor:(NSString*)descriptor {
    
    NSMutableArray *array = [NSMutableArray array];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    NSSortDescriptor * newSortDescriptor = [[NSSortDescriptor alloc] initWithKey:descriptor ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:newSortDescriptor];
    NSSet *setArray = [NSSet setWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    return setArray.allObjects;
}

- (NSArray*)projectImagesRLMResultsToArray:(RLMResults *)results {
    
    NSMutableArray *array = [NSMutableArray array];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    NSSortDescriptor * newSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"imagePrimaryID" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:newSortDescriptor];
    array = [NSMutableArray arrayWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    return array;
}
@end
