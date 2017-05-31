//
//  APUser.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Realm/Realm.h>

@interface APUser : RLMObject

@property (strong, nonatomic) NSString *email;
@property (nonatomic) NSInteger userId;

@end

RLM_ARRAY_TYPE(APUser)
