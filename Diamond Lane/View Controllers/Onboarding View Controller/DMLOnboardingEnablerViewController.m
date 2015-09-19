//
//  DMLOnboardingEnablerViewController.m
//  Diamond Lane
//
//  Created by Kieran on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingEnablerViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "DMLLocationManager.h"

@interface DMLOnboardingEnablerViewController ()

@end

@implementation DMLOnboardingEnablerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (IBAction)okButtonTapped:(id)sender {
    
    // checks if location service is enabled for the app
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        UIAlertController* disabledLocationServiesAlert = [UIAlertController alertControllerWithTitle:@"Location services disabled" message:@"Please enable location services on your device" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                              
        }];
        
        [disabledLocationServiesAlert addAction:defaultAction];
        [self presentViewController:disabledLocationServiesAlert animated:YES completion:nil];
    }
    
    // to do enable push
    
    [DMLLocationManager requestLocationPermission];
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        
        // push home view controller
        
    }

}

@end
