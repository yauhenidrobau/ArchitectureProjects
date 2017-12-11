//
//  APProjectManager.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APProjectManager.h"

#import <Firebase.h>
#import "Macros.h"
#import "APNetworkHelper.h"
#import "APRealmManager.h"
#import "APProjectObject.h"
#import "APKeychainManager.h"
#import "APDownloadHelper.h"


@interface APProjectManager () 
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation APProjectManager
SINGLETON(APProjectManager)



#pragma mark - Public

- (void)loadProjectsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion {
    [[APRealmManager sharedInstance] cachedObjectsWithCallback:^(NSArray *objects, NSError *error) {
        if (completion) {
            completion(objects, NO, nil);
        }
        if ([APNetworkHelper isInternetConnected]) {
            self.ref = [[FIRDatabase database] reference];
            NSString *email = [APKeychainManager sharedInstance].storedEmail;
            NSLog(@"----- Login in Firebase -----");
            
            [[FIRAuth auth] signInWithEmail:email password:email completion:^(FIRUser *user, NSError *error) {
                if (user && !error) {
                    NSLog(@"----- Get Projects -----");
                    
                    [[self.ref child:@"projects"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                        // Get user value
                        NSDictionary *projectDict = [self parseObjectsFromJSON:snapshot];
                        NSLog(@"----- Save Projects -----");
                        [[APRealmManager sharedInstance]saveToProject:projectDict withCallback:^(NSError *error) {
                            [[APRealmManager sharedInstance] cachedObjectsWithCallback:^(NSArray *objects, NSError *error) {
                                if (completion) {
                                    completion(objects, YES, error);
                                }
                            }];
                        }];
                    } withCancelBlock:^(NSError * _Nonnull error) {
                        NSLog(@"%@", error.localizedDescription);
                        [[APRealmManager sharedInstance] cachedObjectsWithCallback:^(NSArray *objects, NSError *error) {
                            if (completion) {
                                completion(objects, YES, error);
                            }
                        }];
                    }];
                } else {
                    [[APRealmManager sharedInstance] cachedObjectsWithCallback:^(NSArray *objects, NSError *error) {
                        if (completion) {
                            completion(objects, YES, error);
                        }
                    }];
                }
            }];
    }
    }];
}

//- (NSArray*)loadProjectsForCategory:(NSString*)category {
//    return [[PLRealmManager instance]loadShopsForCategory:category];
//}
//
//- (NSArray*)loadCategories {
//    return [[PLRealmManager instance] loadShopCategories];
//}

#pragma mark - Private

- (NSDictionary*)parseObjectsFromJSON:(FIRDataSnapshot *)JSON {
    NSError *error = nil;
    NSDictionary *shopList = [JSON valueInExportFormat];
    if (error) {
        NSLog(@"Error reading file: %@",error.localizedDescription);
        return @{};
    } else {
        return  shopList;
    }
}


@end
