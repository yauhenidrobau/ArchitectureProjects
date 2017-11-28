//
//  RecommendationObject.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/17/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Realm/Realm.h>

@interface RecommendationObject : RLMObject

@property (strong, nonatomic) NSString *name;

@end

RLM_ARRAY_TYPE(RecommendationObject)

