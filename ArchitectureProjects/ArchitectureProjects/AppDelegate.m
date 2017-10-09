//
//  AppDelegate.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/16/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import <AFNetworking.h>
#import <IQKeyboardManager.h>
#import "UIViewController+ShowModal.h"
#import "SimpleModalVC.h"
#import "Macros.h"
#import "APKeychainManager.h"
#import "APProjectManager.h"
#import "APUserManager.h"
#import "UIAlertController+AP.h"
#import "APConstants.h"
#import <SVProgressHUD.h>
#import "APLocationManager.h"
#import "UIColor+App.h"

@import Firebase;
@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate () {
    BOOL showOfflineAlert;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /*
     Fabric
     */
    [Fabric with:@[[Crashlytics class]]];
    
    /*
     Setup Root Controller
     */
    [self setupRootVC];

    /*
     FireBase
     */
    [FIRApp configure];
    
    /*
     Appierance
     */
    [self setupAppearance];
    
    /*
     Reachability
     */
    [self startReachabilityMonitoring];
    
    /*
     Google Maps
     */
    [GMSServices provideAPIKey:GOOGLE_MAPS_API_KEY];
    [GMSPlacesClient provideAPIKey:GOOGLE_MAPS_API_KEY];

    /*
     SVProgressHUD
     */
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOfflineAlert) name:NN_NETWORK_STATE_OFFLINE object:nil];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Reachability

- (void)startReachabilityMonitoring {
    showOfflineAlert = YES;
    self.reachability = [GCNetworkReachability reachabilityWithHostName:@"www.google.com"];
    [self.reachability startMonitoringNetworkReachabilityWithHandler:^(GCNetworkReachabilityStatus status) {
        // this block is called on the main thread
        switch (status) {
            case GCNetworkReachabilityStatusNotReachable:
                [self showOfflineAlert];
                break;
            case GCNetworkReachabilityStatusWWAN:
            case GCNetworkReachabilityStatusWiFi:
                if (!showOfflineAlert) {
//                    [self showOfflineAlert];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:NN_NETWORK_STATE_OK object:nil];
                }
                showOfflineAlert = YES;
                break;
        }
    }];
}

#pragma mark - Private

- (void)showOfflineAlert {
    if (showOfflineAlert) {
        UIAlertController* alert = [UIAlertController alertWithOfflineError];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        alert.view.tintColor = [UIColor blackColor];
        showOfflineAlert = NO;
    }
}

- (void)setupRootVC{
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController* rootVC = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    self.window.rootViewController = rootVC;
}

- (void)setupAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0 / 255.0 green:35.0 / 255.0 blue:35.0 / 255.0 alpha:1]];
    
    [[UINavigationBar appearance]setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor app_secondColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor app_secondColor],
                                                           NSFontAttributeName: [UIFont systemFontOfSize:17.f]}];
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary  dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    [[IQKeyboardManager sharedManager]setEnable:YES];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100.f;
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarByTag;
}

@end
