//
//  VehicleAnnotation.h
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleAnnotation : MKPointAnnotation
    @property (nonatomic) CLLocationDegrees heading;
    @property (nonatomic, nonnull) NSString *markerImageName;
@end

NS_ASSUME_NONNULL_END
