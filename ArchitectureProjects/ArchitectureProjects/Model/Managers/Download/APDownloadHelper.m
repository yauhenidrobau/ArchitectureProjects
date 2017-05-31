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
    NSOperationQueue *queue;
}

@end
@implementation APDownloadHelper
SINGLETON(APDownloadHelper)


-(id)init {
    self = [super init];
    if (self) {
        queue = [[NSOperationQueue alloc]init];
        queue.maxConcurrentOperationCount = 1;
        [queue waitUntilAllOperationsAreFinished];
        [queue addObserver:self forKeyPath:@"operations" options:0 context:&kQueueOperationsChanged];
        
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
    
    for (APProjectObject *object in projects) {
        NSString *title = object.name;
       __block NSInteger index = object.projectId;
        NSArray *images = [[APRealmManager sharedInstance]projectImagesRLMResultsToArray:object.images];
        __block NSInteger imageIndex = 1;

        for (NSString *imageString in images) {
            if (![APFileHelper getImagePath:title forImageIndex:imageIndex].length) {
                [queue addOperationWithBlock:^{
                    NSString *imagePathInStorage = [NSString stringWithFormat:@"%@/%@.%ld.jpg",title,title,imageIndex];
                    FIRStorageReference *storageRef = [storage referenceWithPath:imagePathInStorage];
                    
                    NSURL *localURL = [NSURL URLWithString:[APFileHelper createFilePath:title forImageIndex:imageIndex]];
                    imageIndex ++;
                    FIRStorageDownloadTask *downloadTask = [storageRef writeToFile:localURL completion:^(NSURL *URL, NSError *error){
                        if (index == projects.count) {
                            if (callback) {
                                callback(error.localizedDescription.length, YES);
                            }
                        } else if (error) {
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
                }];
            }
        }
        index ++;
    }

}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    if (object == queue && [keyPath isEqualToString:@"operations"] && context == &kQueueOperationsChanged) {
        if ([queue.operations count] == 0) {
            // Do something here when your queue has completed
            NSLog(@"queue has completed");
            [queue removeObserver:self forKeyPath:@"operations" context:&kQueueOperationsChanged];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

@end
