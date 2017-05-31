//
//  APUserManager.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Macros.h"
#import "APUser.h"

@interface APUserManager : NSObject

@property (nonatomic, strong, readonly) APUser* currentUser;
@property (readonly) BOOL isUserAuthorised;

+(instancetype)sharedInstance;

- (void)loginUserWithEmail:(NSString*)email withCompletion:(APUserManagerLoginCompletion)completion;

@end
