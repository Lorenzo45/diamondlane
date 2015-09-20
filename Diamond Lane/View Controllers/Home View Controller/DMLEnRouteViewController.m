//
//  DMLEnRouteViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLEnRouteViewController.h"

@import MapKit;

@interface DMLEnRouteViewController ()

@property (nonatomic, readonly, strong) MKMapView *mapView;

@end

@implementation DMLEnRouteViewController

@synthesize mapView=_mapView;
-(MKMapView *)mapView {
    
    if (!_mapView) {
        
        _mapView = [[MKMapView alloc] init];
        [_mapView setShowsUserLocation:YES];
        [[self view] addSubview:_mapView];
        
    }
    return _mapView;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // view heirarchy
    
    [self mapView];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [[self mapView] setFrame:[[self view] bounds]];
    
}

@end
