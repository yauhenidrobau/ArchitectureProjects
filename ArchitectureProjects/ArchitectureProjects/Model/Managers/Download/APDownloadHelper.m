 //
//  APDownloadHelper.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APDownloadHelper.h"
#import "APProjectObject.h"
#import <FirebaseStorage/FirebaseStorage.h>
#import "APFileHelper.h"
#import "Macros.h"
#import "APRealmManager.h"

static NSString *kQueueOperationsChanged = @"kQueueOperationsChanged";

@interface APDownloadHelper () {
    dispatch_queue_t queue;
}

@end
@implementation APDownloadHelper
SINGLETON(APDownloadHelper)


-(id)init {
    self = [super init];
    if (self) {
        queue = dispatch_queue_create_with_target("com.", DISPATCH_QUEUE_CONCURRENT, nil);
        return self;
    }
    return nil;
}

//+ (void)downloadResourcesForShops:(NSArray*)shops withCallback:(void(^)(BOOL isFinished))callback {
//    __block NSInteger index = 0;
//    for (PLShop *shop in shops) {
//        if (![PLFileHelper getShopPath:shop.title forImageType:ImageTypeLogo].length) {
//            [self downloadImageForShop:shop.title withImageType:ImageTypeLogo withCallback:^(BOOL downloaded) {
//                if (downloaded) {
//                    index++;
//                    if (index == shops.count) {
//                        if (callback) {
//                            callback(YES);
//                        }
//                    } else {
//                        if (callback) {
//                            callback(NO);
//                        }
//                    }
//                }
//            }];
//            [self downloadImageForShop:shop.title withImageType:ImageTypeBanner withCallback:^(BOOL downloaded) {
//                if (callback) {
//                    callback(NO);
//                }
//            }];
//            
//        } else {
//            if (callback) {
//                callback(YES);
//            }
//        }
//    }
//}

- (void)downloadImageForProjects:(NSArray*)projects withCallback:(void(^)(BOOL downloaded, BOOL finished))callback {

    FIRStorage *storage = [FIRStorage storage];
    dispatch_group_t group = dispatch_group_create();

        for (APProjectObject *object in projects) {

            NSString *title = object.name;
            __block NSInteger index = object.projectId;
            NSArray *images = [[APRealmManager sharedInstance]projectImagesRLMResultsToArray:object.images];
            __block NSInteger imageIndex = 1;
            
            for (NSString *imageString in images) {
                if (![APFileHelper getImagePath:title forImageIndex:imageIndex].length) {
                    
                    NSString *imagePathInStorage = [NSString stringWithFormat:@"%@/%@.%ld.jpg",title,title,imageIndex];
                    FIRStorageReference *storageRef = [storage referenceWithPath:imagePathInStorage];
                    
                    NSURL *localURL = [NSURL URLWithString:[APFileHelper createFilePath:title forImageIndex:imageIndex]];
                    imageIndex ++;
                    dispatch_group_async(group, queue, ^{
                    FIRStorageDownloadTask *downloadTask = [storageRef writeToFile:localURL completion:^(NSURL *URL, NSError *error){
                        if (error) {
                            NSLog(@"downloaded ERROR");
                            if (callback) {
                                callback(NO,NO);
                            }
                        } else {
                            NSLog(@"downloaded : %@ : %ld",title, imageIndex);
                            if (callback) {
                                callback(YES, NO);
                            }
                        }
                        
                    }];
                    });
                }
            }
        }
    dispatch_group_notify(group, queue, ^{
        if (callback) {
            callback(NO, YES);
        }
    });
}


@end
