//
//  DMLLocationManager.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DMLLocationManager : NSObject

+(void)requestLocationPermission;
+(void)startMonitoringGeofences;
+(void)stopMonitoringGeofences;
+(void)addGeofenceforLocation:(CLLocationCoordinate2D)location withIdentifier:(NSString *)identifier;

@end
