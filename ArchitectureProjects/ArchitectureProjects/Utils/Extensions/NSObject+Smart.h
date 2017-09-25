//
//  NSObject+Smart.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/25/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Smart)

@end

#pragma mark - Extern
#define EXTERN_STRING_H(name) extern NSString * const (name)
#define EXTERN_STRING_M(name) NSString * const (name) = (@""#name);

#define SINGLETON(classname) \
+ (classname *)sharedInstance { \
static dispatch_once_t pred; \
__strong static classname * shared##classname = nil; \
dispatch_once( &pred, ^{ \
shared##classname = [[self alloc] init]; }); \
return shared##classname; \
}
