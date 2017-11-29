//
//  APMapViewController.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 8/15/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APMapViewController.h"

#import "APConstants.h"
#import "Macros.h"
#import "APLocationManager.h"
#import <SVProgressHUD.h>
#import "UIColor+App.h"

@import GoogleMaps;

@interface APMapViewController () <GMSMapViewDelegate, APLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isFirstStart;
@end

@implementation APMapViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstStart = YES;
    
    self.mapView.delegate = self;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.userLocation = [APLocationManager sharedInstance].manager.location;
    [APLocationManager sharedInstance].locationManagerDelegate = self;
    [SVProgressHUD setContainerView:self.mapView];
    self.navigationController.navigationBar.hidden = YES;
//    [self updateLocationPermissions];
    self.locationButton.layer.cornerRadius = self.locationButton.frame.size.height / 2;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateLocationPermissions) userInfo:nil repeats:YES];
    });
}

#pragma mark - IBAction
- (IBAction)centerOnUser:(id)sender {
    [self centerUser];
}

#pragma mark - APLocationManagerDelegate
- (void)locationManagerDidUpdateLocation:(CLLocation *)location {
    if ((self.userLocation.coordinate.latitude != location.coordinate.latitude || self.userLocation.coordinate.longitude != location.coordinate.longitude) && CLLocationCoordinate2DIsValid(self.userLocation.coordinate) && self.isFirstStart) {
        self.userLocation = location;
        [self prepareMapView];
        
    }
}

#pragma mark - Private
- (void)updateLocationPermissions {
    if ([APLocationManager sharedInstance].isAvailable) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.timer invalidate];
            self.timer = nil;
        });
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([APLocationManager sharedInstance].isAvailable) {
            [self prepareMapView];
            [[APLocationManager sharedInstance] startUpdatingLocation];
            
        }
    });
}

- (void)centerUser {
    GMSCoordinateBounds *bounds = [GMSCoordinateBounds new];
    bounds = [bounds includingCoordinate:self.userLocation.coordinate];
    bounds = [bounds includingCoordinate:OUR_LOCATION];
    [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds
                                                      withEdgeInsets:UIEdgeInsetsMake(20, 20, 40, 80)]];
}

- (void)prepareMapView {
    
    CLLocationCoordinate2D destinationCoordinate = OUR_LOCATION;
    GMSMarker *destinationMarker = [[GMSMarker alloc]init];
    destinationMarker.position = destinationCoordinate;
    destinationMarker.icon = [UIImage imageNamed:@"marker-icon"];
    destinationMarker.title = @"We are here!";

    destinationMarker.groundAnchor = CGPointMake(0.5, 0.5);
    destinationMarker.map = self.mapView;

    GMSMarker *myLocationMarker = [[GMSMarker alloc]init];
    myLocationMarker.position = self.userLocation.coordinate;
    myLocationMarker.icon = [UIImage imageNamed:@"location-icon"];
    myLocationMarker.title = @"You are here!";
    
    myLocationMarker.groundAnchor = CGPointMake(0.5, 0.5);
    myLocationMarker.map = self.mapView;
    
    
    NSString *originString = [NSString stringWithFormat:@"%f,%f", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude];
    NSString *destinationEncodedString = [[NSString stringWithFormat:@"%f,%f", destinationCoordinate.latitude, destinationCoordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationEncodedString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    if (self.isFirstStart) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"map.routing.title", nil)];
        [self centerUser];
        self.isFirstStart = NO;
    }

    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     
                                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                                         if (error) {
                                                             //                                                             mapStatusLabel.text = @"Drawing route failed";
                                                             NSLog(@"error: %@", error);
                                                             return;
                                                         }
                                                         
                                                         NSArray *routesArray = [json objectForKey:@"routes"];
                                                         
                                                         GMSPolyline *polyline = nil;
                                                         if ([routesArray count] > 0) {
                                                             NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                             NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                             NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                             GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                             polyline = [GMSPolyline polylineWithPath:path];
                                                         }
                                                         
                                                         if(polyline) {
                                                             polyline.map = self.mapView;
                                                             polyline.strokeWidth = 4.f;
                                                             polyline.strokeColor = [UIColor app_mainColor];
                                                         }
                                                         [SVProgressHUD dismissWithDelay:0.5];
                                                         //                                                         mapStatusLabel.text = @"Drawing route completed";
                                                         
                                                     });
                                                 }];
    [fetchDirectionsTask resume];
}
@end
