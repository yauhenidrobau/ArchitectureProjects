//
//  APKeychainManager.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APKeychainManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)storeUserEmailToKeychain:(NSString*)email;
- (NSString*)storedEmail;

@end
