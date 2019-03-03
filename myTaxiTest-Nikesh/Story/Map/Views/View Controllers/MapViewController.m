//
//  MapViewController.m
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

#import "MapViewController.h"
#import "VehicleAnnotation.h"
#import "MapBoundCoordinates.h"

@implementation MapViewController
// MARK:- Life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MapViewViewModel alloc] init];
    self.viewModel.vehicleMarkersDelegate = self;
    [self configureBottomStatView];
    self.loader = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    self.mapView.delegate = self;
    CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(50.694865, 9.757589);
    MKCoordinateRegion visibleRegion = MKCoordinateRegionMakeWithDistance(loc1, 1300, 1300);
    [self.mapView setRegion:visibleRegion animated:YES];
    
}

// MARK:- View Data Coordination Methods

/**
 Requests view model to fetch vehicles in current visible region edge coordinates

 @param loc1 First edge location coordinate value
 @param loc2 Second edge location coordinate value
 */
- (void)fetchVehiclesInRegion:(CLLocationCoordinate2D)loc1 :(CLLocationCoordinate2D)loc2 {
    [self.viewModel fetchVehiclesInRegionWithLoc1:loc1 loc2:loc2];
}

- (void)configureBottomStatView {
    [self.bottomListContainer addDropShadowWithColor:UIColor.blackColor opacity:1 offSet:CGSizeMake(0, -5) radius:25 scale:YES];
    [self.centerMarkerView addDropShadowWithColor:UIColor.blackColor opacity:0.6 offSet:CGSizeMake(0, 0) radius:4 scale:YES];
    
    [self.bottomListContainer addSubview:self.addressStatisticsView];
    [self.bottomListContainer bringSubviewToFront:self.addressStatisticsView];
    self.addressStatisticsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addressStatisticsView.trailingAnchor constraintEqualToAnchor:self.bottomListContainer.trailingAnchor constant:0].active = YES;
    [self.addressStatisticsView.leadingAnchor constraintEqualToAnchor:self.bottomListContainer.leadingAnchor constant:0].active = YES;
    [self.addressStatisticsView.topAnchor constraintEqualToAnchor:self.bottomListContainer.topAnchor constant:0].active = YES;
    [self.addressStatisticsView.bottomAnchor constraintEqualToAnchor:self.bottomListContainer.bottomAnchor constant:0].active = YES;
    [self.addressStatisticsView setHidden:YES];
    
    self.driverDetailsView = [[DriverInfoView alloc] init];
    [self.driverDetailsView setFrame:[self.bottomListContainer bounds]];
    [self.driverDetailsView addToViewWithView:self.bottomListContainer];
}
    
// MARK:- Map View Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    VehicleAnnotation *vehicleAnnotation = (VehicleAnnotation*) annotation;
    NSString *annotationIdentifier = @"vehicleMarker";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if(annotationView == nil){
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        annotationView.canShowCallout = YES;
    }
    else {
        annotationView.annotation = annotation;
    }
    UIImage *customImage = [UIImage imageNamed: vehicleAnnotation.markerImageName];
    annotationView.image = customImage;
    CGFloat angle = (CGFloat) vehicleAnnotation.heading / (180 * M_PI);
    annotationView.transform = CGAffineTransformMakeRotation(angle);
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    view.transform = CGAffineTransformMakeScale(1.8, 1.8);
    DriverDetailsViewModel *model = [self.viewModel didTapAnnotationWithAnnotation:view.annotation];
    if(model){
        [self.driverDetailsView refreshWithViewModelWithModel:model];
        [self.driverDetailsView setVisibleInViewWithView:self.bottomListContainer];
        
    }
}
    
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    view.transform = CGAffineTransformMakeScale(1, 1);
    [self.driverDetailsView closeView];
}
    
- (void)convertLocationToAddress:(CLLocationCoordinate2D)location {
    [self.loader showInView:self.bottomListContainer];
    [self.addressStatisticsView setHidden:YES];
    CLGeocoder *address = [[CLGeocoder alloc] init];
    [address cancelGeocode];
    CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [address reverseGeocodeLocation:clLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(placemarks) {
            NSString *city = placemarks.firstObject.thoroughfare ? placemarks.firstObject.thoroughfare : placemarks.firstObject.administrativeArea;
            NSString *country = placemarks.firstObject.country;
            [self.centerCoordinateAddressLabel setText:city];
            [self.addressStatisticsView updateViewWithAddressWithCoordinate:location city:city country:country animated:YES];
            
        } else {
            NSLog(@"Geocode failed");
        }
        [self.loader dismissAnimated:YES];
    }];
}
    
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MapBoundCoordinates *bounds = [mapView getVisibleBoundCoordinates];
    [self fetchVehiclesInRegion:bounds.pointOne :bounds.pointTwo];
    [self.centerCoordinateAddressLabel setText:@"Loading..."];
    [self convertLocationToAddress:mapView.centerCoordinate];
}
    
    
// Vehicle Markers List Fetch Delegate
- (void)didFetchMarkersDataSuccessfully {
    [self.viewModel updateMapWithBoundMarkersWithMap:self.mapView];
}
    
- (void)didFailFetchingMarkersDataWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}
    
- (void)clearMapViewMarkersWithMarkers:(NSArray<id<MKAnnotation>> *)markers {
    [self.mapView removeAnnotations:markers];
}
    
- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
