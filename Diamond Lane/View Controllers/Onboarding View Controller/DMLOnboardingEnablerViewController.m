//
//  DMLOnboardingEnablerViewController.m
//  Diamond Lane
//
//  Created by Kieran on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingEnablerViewController.h"
#import "DMLSplashViewController.h"

#import <CoreLocation/CoreLocation.h>

#import "DMLLocationManager.h"

@interface DMLOnboardingEnablerViewController ()

@end

@implementation DMLOnboardingEnablerViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    

}

-(IBAction)okButtonTapped:(id)sender {
    
    // checks if location service is enabled for the app
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        [self showDisabledLocationPopup];
        
    } else {
        
        // location is enabled, registers for push
        
        [self enablePushNotifications];
        
        [self requestLocationPermission];
        
    }

}

-(void)enablePushNotifications {
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
}

-(void)showDisabledLocationPopup {
    
    UIAlertController* disabledLocationServiesAlert = [UIAlertController alertControllerWithTitle:@"Location services disabled" message:@"Please enable location services on your device" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    
    [disabledLocationServiesAlert addAction:defaultAction];
    [self presentViewController:disabledLocationServiesAlert animated:YES completion:nil];
    
}

-(void)requestLocationPermission {
    
    [DMLLocationManager requestLocationPermission];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DMLSplashViewControllerDoneOnboardingNotificationName object:nil];
    
}

@end
