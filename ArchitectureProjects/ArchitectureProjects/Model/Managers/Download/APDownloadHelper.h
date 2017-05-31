//
//  APDownloadHelper.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APDownloadHelper : NSObject

+(instancetype)sharedInstance;

- (void)downloadResourcesForShops:(NSArray*)shops withCallback:(void(^)(BOOL isFinished))callback;
- (void)downloadImageForProjects:(NSArray*)projects withCallback:(void(^)(BOOL downloaded, BOOL finished))callback;

@end
