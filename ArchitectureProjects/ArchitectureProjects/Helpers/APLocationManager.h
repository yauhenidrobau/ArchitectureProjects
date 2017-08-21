//
//  APLocationManager.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Macros.h"

@protocol APLocationManagerDelegate <NSObject>

-(void)locationManagerDidUpdateLocation:(CLLocation*)location;

@end
@interface APLocationManager : NSObject

+(instancetype)sharedInstance;

@property (nonatomic,readonly) BOOL isAvailable;
@property (strong,nonatomic) CLLocationManager *manager;

@property (weak,nonatomic) id <APLocationManagerDelegate> locationManagerDelegate;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
