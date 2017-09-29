//
//  AppDelegate.h
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GCNetworkReachability.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) GCNetworkReachability* reachability;
@property (strong, nonatomic) UIWindow *window;


@end

