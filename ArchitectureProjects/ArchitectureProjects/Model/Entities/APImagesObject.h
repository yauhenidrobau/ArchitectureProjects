//
//  APImagesObject.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Realm/Realm.h>

@interface APImagesObject : RLMObject
@property NSInteger imageID;
@property NSInteger imagePrimaryID;

@property (strong, nonatomic) NSString *image;
@end

RLM_ARRAY_TYPE(APImagesObject)
