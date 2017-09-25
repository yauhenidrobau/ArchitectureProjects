//
//  APNetworkHelper.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APNetworkHelper.h"

#import "GCNetworkReachability.h"
#import "Macros.h"

@implementation APNetworkHelper

+(BOOL)isInternetConnected {
    GCNetworkReachability *reachability = [GCNetworkReachability reachabilityForInternetConnection];
    return reachability.isReachable;
}
@end
