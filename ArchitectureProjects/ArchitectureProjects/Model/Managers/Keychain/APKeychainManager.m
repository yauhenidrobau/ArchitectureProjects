//
//  APKeychainManager.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APKeychainManager.h"

#import <SAMKeychain.h>
#import "Macros.h"

#define SERVICE_NAME_FOR_EMAIL @"emailService"
static NSString * const kKeychainAccountEmail = @"email";

@implementation APKeychainManager

SINGLETON(APKeychainManager)

#pragma mark - Public

- (BOOL)storeUserEmailToKeychain:(NSString*)email {
    NSError *emailError = nil;
    [SAMKeychain setPassword:email forService:SERVICE_NAME_FOR_EMAIL account:kKeychainAccountEmail error:&emailError];
    if (emailError) {
        NSLog(@"Can't store email into keychain! EmailError: %@ ", emailError);
        return NO;
    }
    return YES;
}

#pragma mark - Override Properties
- (NSString*)storedEmail {
    return [SAMKeychain passwordForService:SERVICE_NAME_FOR_EMAIL account:kKeychainAccountEmail];
}


@end
