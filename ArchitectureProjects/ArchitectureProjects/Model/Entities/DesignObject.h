//
//  DesignObject.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/28/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Realm/Realm.h>

@interface DesignObject : RLMObject

@property (nonatomic) NSInteger designID;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *fullDescription;

@end

RLM_ARRAY_TYPE(DesignObject)
