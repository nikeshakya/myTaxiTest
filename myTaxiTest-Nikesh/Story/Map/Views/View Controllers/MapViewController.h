//
//  MapViewController.h
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "myTaxiTest_Nikesh-Swift.h"
#import "JGProgressHUD/JGProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MapMarkersUpdateDelegate, MKMapViewDelegate>
    
    @property (weak, nonatomic) IBOutlet RoundedView *centerMarkerView;
    @property (weak, nonatomic) IBOutlet UILabel *centerCoordinateAddressLabel;
    @property (weak, nonatomic) IBOutlet MKMapView *mapView;
    @property (weak, nonatomic) IBOutlet UIView *bottomListContainer;
    @property (strong, nonatomic) IBOutlet MapBottomStatView *addressStatisticsView;
- (IBAction)backTapped:(id)sender;
    
    @property (strong, nonatomic) DriverInfoView *driverDetailsView;
    @property (strong, nonatomic) MapViewViewModel *viewModel;
    @property (strong, nonatomic) JGProgressHUD *loader;
    
    typedef enum {
        taxi = 1,
        pooling = 2
    } MarkerType;
    
    - (void) convertLocationToAddress:(CLLocationCoordinate2D)location;
    - (void) configureBottomStatView;
    - (void) fetchVehiclesInRegion: (CLLocationCoordinate2D)loc1 :(CLLocationCoordinate2D)loc2;
@end

NS_ASSUME_NONNULL_END
