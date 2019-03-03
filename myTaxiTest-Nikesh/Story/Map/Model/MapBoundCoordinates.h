//
//  MapBoundCoordinates.h
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapBoundCoordinates : NSObject
    @property (nonatomic) CLLocationCoordinate2D pointOne;
    @property (nonatomic) CLLocationCoordinate2D pointTwo;
@end

NS_ASSUME_NONNULL_END
