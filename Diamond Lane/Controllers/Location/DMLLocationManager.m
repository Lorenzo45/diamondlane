//
//  DMLLocationManager.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLLocationManager.h"

@implementation DMLLocationManager

static CLLocationManager *manager;
static NSMutableArray *geofenceRegions;
static int defaultRadius = 30; // in meters

+(void)initialize {
    manager = [[CLLocationManager alloc] init];
}

+(void)requestLocationPermission {
    [manager requestAlwaysAuthorization];
}

+(void)startMonitoringGeofences {
    for (CLCircularRegion *region in geofenceRegions) {
        [manager startMonitoringForRegion:region];
    }
}

+(void)stopMonitoringGeofences {
    for (CLCircularRegion *region in geofenceRegions) {
        [manager stopMonitoringForRegion:region];
    }
}

+(void)addGeofenceforLocation:(CLLocationCoordinate2D)location withIdentifier:(NSString *)identifier {
    [geofenceRegions addObject:[[CLCircularRegion alloc] initWithCenter:location radius:defaultRadius identifier:identifier]];
}

@end
