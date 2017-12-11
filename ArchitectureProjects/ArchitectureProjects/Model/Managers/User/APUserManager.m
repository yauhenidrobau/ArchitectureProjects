//
//  APUserManager.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APUserManager.h"

#import "NSString+AP.h"
#import "APRealmManager.h"
#import "APKeychainManager.h"
#import <Firebase.h>
#import "APConstants.h"

@implementation APUserManager

SINGLETON(APUserManager)

#pragma mark - Override Proerties
- (BOOL)isUserAuthorised {
    NSString *email = [[APKeychainManager sharedInstance] storedEmail];
    return email.length;
}

#pragma mark - Public
- (void)loginUserWithEmail:(NSString*)email withCompletion:(APUserManagerLoginCompletion)completion {
    if (![email isValidEmail]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion ([NSError errorWithDomain:@"UserManager" code:-1 userInfo:@{@"description" : @"wrong input data"}]);
            }
        });
        return;
    }
    
    //TODO: needs refactoring
    NSLog(@"----- Login in FireBase -----");

    [[FIRAuth auth] createUserWithEmail:email password:email completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
        NSLog(@"%@",user);
        if (!error || [error  code] == LOGIN_IS_ALREADY_EXISTS_CODE) {
            NSLog(@"----- Save User -----");

            [[APRealmManager sharedInstance]saveUserWithEmail:email withCallback:^(NSError *saveError) {
                if (!saveError) {
                    BOOL success = [[APKeychainManager sharedInstance]storeUserEmailToKeychain:email];
                    if (success) {
                        if (completion) {
                            completion (nil);
                        }
                    } else {
                        if (completion) {
                            completion ([NSError errorWithDomain:@"KeyChainManager" code:-1 userInfo:@{@"description" : @"email does not saved"}]);
                        }
                    }
                } else {
                    if (completion) {
                        completion ([NSError errorWithDomain:@"RealmDataManager" code:-1 userInfo:@{@"description" : @"email does not saved"}]);
                    }
                }
            }];
        } else {
            if (completion) {
                completion (error);
            }
        }
    }];
}

@end
