//
//  APFileHelper.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APFileHelper.h"

@implementation APFileHelper

+ (NSString*)createFilePath:(NSString*)title forImageIndex:(NSInteger)index {
    
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSError *error = nil;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:BASEURL];
    
    BOOL isDirectory;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",title]];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%ld.jpg",title,index]];
    [fileManager createFileAtPath:path contents:nil attributes:nil];
    NSLog(@"Create path : %@",path);
    
    return  [NSString stringWithFormat:@"file://\%@",path];
}

+ (NSString*)getImagePath:(NSString*)filename forImageIndex:(NSInteger)index {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:BASEURL];
    path = [path stringByAppendingPathComponent:filename];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%ld.jpg",filename,index]];

    if (![NSData dataWithContentsOfFile:path].length) {
        return @"";
    } else {
    }
    return path;
}

@end
