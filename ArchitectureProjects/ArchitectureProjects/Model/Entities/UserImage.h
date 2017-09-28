//
//  UserImage.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/26/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Realm/Realm.h>

#import <UIKit/UIKit.h>

@interface UserImage : RLMObject

@property (nonatomic) NSInteger primaryId;
@property (nonatomic) NSInteger imageId;

@property (strong, nonatomic) NSData *imageData;

- (UIImage*)image;

@end

RLM_ARRAY_TYPE(UserImage)

