//
//  APImagesObject.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Realm/Realm.h>

@interface APImagesObject : RLMObject
@property NSInteger imagePrimaryID;

@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSData *imageData;
@property (nonatomic, strong) NSString *captionTitle;
@property (nonatomic, strong) NSString *captionSummary;
@property (nonatomic, strong) NSString *captionCredit;
@end

RLM_ARRAY_TYPE(APImagesObject)
