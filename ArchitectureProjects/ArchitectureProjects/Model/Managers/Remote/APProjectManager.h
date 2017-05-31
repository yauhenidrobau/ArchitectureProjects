//
//  APProjectManager.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APProjectManager : NSObject

+(instancetype)sharedInstance;

- (void)loadProjectsWithCompletion:(void(^)(NSArray *projects, BOOL finished, NSError *error))completion;

@end
