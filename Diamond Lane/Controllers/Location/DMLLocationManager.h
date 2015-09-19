//
//  DMLLocationManager.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol DMLLocationObserver;

@class CLLocation;

@interface DMLLocationManager : NSObject

@property (nonatomic, readonly, strong) CLLocation *currentLocation;

-(void)addObserver:(id <DMLLocationObserver>)observer;
-(void)removeObserver:(id <DMLLocationObserver>)observer;

+(void)requestAuthorization;

+(instancetype)sharedInstance;

@end

@protocol DMLLocationObserver <NSObject>

@optional
-(void)locationManager:(DMLLocationManager *)locationManager didUpdateLocation:(CLLocation *)location;
-(void)locationManager:(DMLLocationManager *)locationManager didEnterRegion:(CLRegion *)region;
-(void)locationManager:(DMLLocationManager *)locationManager didExitRegion:(CLRegion *)region;

@end
