//
//  APProjectObject.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/18/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Realm/Realm.h>
#import "APImagesObject.h"

@interface APProjectObject : RLMObject

@property  NSInteger projectId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) RLMArray<APImagesObject *><APImagesObject> *images;
@property (strong, nonatomic) NSString *totalArea;
@property (strong, nonatomic) NSString *dwellingSpace;
@property (strong, nonatomic) NSString *rooms;
@property (strong, nonatomic) NSString *interiorЕrim;
@property (strong, nonatomic) NSString *category;

@end

RLM_ARRAY_TYPE(APProjectObject)
