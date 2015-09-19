//
//  DMLLocationManager.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLLocationManager.h"

@import CoreLocation;

@interface DMLLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, readonly, strong) CLLocationManager *locationManager;
@property (nonatomic, readonly, strong) NSMutableArray <NSValue *> *observers;

@end

@implementation DMLLocationManager

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        [DMLLocationManager requestAuthorization];
        
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        _locationManager = locationManager;
        
        // start monitoring for location
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [locationManager setDistanceFilter:20.0];
        [locationManager startUpdatingLocation];
        
        // start monitoring for beacons
        
        NSArray *regions = [[[self locationManager] monitoredRegions] allObjects];
        [regions enumerateObjectsUsingBlock:^(CLRegion *region, NSUInteger idx, BOOL *stop) {
            
            [locationManager stopMonitoringForRegion:region];
            
        }];
        
    }
    return self;
    
}

#pragma mark - Authorization

+(void)requestAuthorization {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    
}

#pragma mark - Observers

@synthesize observers=_observers;
-(NSMutableArray *)observers {
    
    if (!_observers) {
        
        _observers = [NSMutableArray array];
        
    }
    return _observers;
    
}

-(void)addObserver:(id<DMLocationObserver>)observer {
    
    if ([[self observers] containsObject:[NSValue valueWithNonretainedObject:observer]]) {
        
        return;
        
    }
    
    [[self observers] addObject:[NSValue valueWithNonretainedObject:observer]];
    
}

-(void)removeObserver:(id<DMLocationObserver>)observer {
    
    [[self observers] removeObject:[NSValue valueWithNonretainedObject:observer]];
    
}

-(void)dispatchToObservers:(void (^)(id <DMLocationObserver>))dispatchBlock {
    
    [[self observers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        dispatchBlock ? dispatchBlock(obj) : nil;
        
    }];
    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    [self dispatchToObservers:^(id<DMLocationObserver> observer) {
        
        if ([observer respondsToSelector:@selector(locationManager:didEnterRegion:)]) {
            
            [observer locationManager:self didEnterRegion:region];
            
        }
        
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    [self dispatchToObservers:^(id<DMLocationObserver> observer) {
        
        if ([observer respondsToSelector:@selector(locationManager:didExitRegion:)]) {
            
            [observer locationManager:self didExitRegion:region];
            
        }
        
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations firstObject];
    if (!location) {
        
        return;
        
    }
    _currentLocation = location;
    
    NSLog(@"Updated to location: %@",location);
    
    [self dispatchToObservers:^(id<DMLocationObserver> observer) {
        
        if ([observer respondsToSelector:@selector(locationManager:didUpdateLocation:)]) {
            
            [observer locationManager:self didUpdateLocation:location];
            
        }
        
    }];
    
}

#pragma mark - Class Methods

+(instancetype)sharedInstance {
    
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!manager) {
            
            manager = [[[self class] alloc] init];
            
        }
        
    });
    return manager;
    
}

@end
