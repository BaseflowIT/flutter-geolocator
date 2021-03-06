//
//  LocationAccuracyHandler.m
//  geolocator
//
//  Created by Floris Smit on 18/06/2021.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationAccuracyHandler.h"

@implementation LocationAccuracyHandler

- (void) getLocationAccuracyWithResult:(FlutterResult)result {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if (@available(iOS 14, *)) {
        switch ([locationManager accuracyAuthorization]) {
            case CLAccuracyAuthorizationFullAccuracy:
                return result([NSNumber numberWithInt:(LocationAccuracy)precise]);
            case CLAccuracyAuthorizationReducedAccuracy:
                return result([NSNumber numberWithInt:(LocationAccuracy)reduced]);
            default:
                // in iOS 14, reduced location accuracy is the default
                return result([NSNumber numberWithInt:(LocationAccuracy)reduced]);
        }
    } else {
        // If the version of iOS is below version number 14, approximate location is not available, thus
        // precise location is always returned
        return result([NSNumber numberWithInt:(LocationAccuracy)precise]);
    }
}

@end
