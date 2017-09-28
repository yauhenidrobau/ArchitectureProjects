//
//  UserImage.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/26/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "UserImage.h"

@implementation UserImage
+ (NSString *)primaryKey {
    return @"primaryId";
}

- (UIImage*)image {
    return [UIImage imageWithData:self.imageData];
}
@end
