//
//  APLocationManager.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APLocationManager.h"
@interface APLocationManager() <CLLocationManagerDelegate>

@end

@implementation APLocationManager
SINGLETON(APLocationManager)

#pragma mark - Init
- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [CLLocationManager new];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.manager requestWhenInUseAuthorization];
        }
        if (self.isAvailable) {
            [self.manager startUpdatingLocation];
        }
    }
    return self;
}

-(BOOL)isAvailable {
    return [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse;
}

- (void)startUpdatingLocation {
    [self.manager startUpdatingLocation];
}

- (void)stopUpdatingLocation {
    [self.manager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManagerDelegate locationManagerDidUpdateLocation:locations.firstObject];
}

@end
