//
//  APFileHelper.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASEURL @"Projects"

@interface APFileHelper : NSObject

+ (NSString*)createFilePath:(NSString*)title forImageIndex:(NSInteger)index;
+ (NSString*)getImagePath:(NSString*)filename forImageIndex:(NSInteger)index;

@end
