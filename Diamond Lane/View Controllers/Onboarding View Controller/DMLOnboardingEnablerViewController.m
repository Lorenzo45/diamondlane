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
#import "DMLNotificationManager.h"

@interface DMLOnboardingEnablerViewController () <UITextFieldDelegate>

@property (nonatomic, readonly, strong) UILabel *instructionsLabel;
@property (nonatomic, readonly, strong) UIButton *goButton;

@end

@implementation DMLOnboardingEnablerViewController

@synthesize instructionsLabel=_instructionsLabel;
-(UILabel *)instructionsLabel {
    
    if (!_instructionsLabel) {
        
        _instructionsLabel = [[UILabel alloc] init];
        [_instructionsLabel setTextAlignment:NSTextAlignmentCenter];
        [_instructionsLabel setTextColor:[UIColor dml_grayColor]];
        [_instructionsLabel setBackgroundColor:[UIColor clearColor]];
        [_instructionsLabel setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightThin]];
        [_instructionsLabel setNumberOfLines:0];
        [[self view] addSubview:_instructionsLabel];
        
    }
    return _instructionsLabel;
    
}

@synthesize goButton=_goButton;
-(UIButton *)goButton {
    
    if (!_goButton) {
        
        _goButton = [[UIButton alloc] init];
        [_goButton addTarget:self action:@selector(okButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_goButton setBackgroundColor:[UIColor dml_tintColor]];
        [_goButton setTitle:@"Sounds Good" forState:UIControlStateNormal];
        [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[_goButton titleLabel] setFont:[UIFont systemFontOfSize:24.0]];
        [[_goButton layer] setCornerRadius:6.0];
        [[self view] addSubview:_goButton];
        
    }
    return _goButton;
    
}

-(void)dealloc {
    
    ;
    
}

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // setup view heirarchy
    
    [self instructionsLabel];
    [self goButton];
    
    // begin
    
    [[self instructionsLabel] setText:[NSString stringWithFormat:@"Hey, %@.\n\nWe need you to enable location access and notifications.",[self name]]];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat const padding = 32.0;
    
    [[self instructionsLabel] setFrame:CGRectMake(0, 0, CGRectGetWidth([[self view] bounds]) - padding * 2.0, 0)];
    [[self instructionsLabel] sizeToFit];
    [[self instructionsLabel] setFrame:CGRectMake(padding, (CGRectGetHeight([[self view] bounds]) - CGRectGetHeight([[self instructionsLabel] bounds])) / 2.0, CGRectGetWidth([[self view] bounds]) - padding * 2, CGRectGetHeight([[self instructionsLabel] bounds]))];
    
    [[self goButton] setFrame:CGRectMake(48.0, CGRectGetHeight([[self view] bounds]) - 48.0 - 64.0, CGRectGetWidth([[self view] bounds]) - 48.0 * 2, 64.0)];
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}

#pragma mark - Actions

-(IBAction)okButtonTapped:(id)sender {
    
    // checks if location service is enabled for the app
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        [self showDisabledLocationPopup];
        
    } else {
        
        // location is enabled, registers for push
        
        [self requestPushNotificationsPermission];
        [self requestLocationPermission];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DMLSplashViewControllerDoneOnboardingNotificationName object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

}

-(void)showDisabledLocationPopup {
    
    UIAlertController *disabledLocationServiesAlert = [UIAlertController alertControllerWithTitle:@"Location services disabled" message:@"Please enable location services on your device" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    
    [disabledLocationServiesAlert addAction:defaultAction];
    [self presentViewController:disabledLocationServiesAlert animated:YES completion:nil];
    
}

-(void)requestPushNotificationsPermission {
    
    [[DMLNotificationManager sharedInstance] registerForPushNotifications];
    
}

-(void)requestLocationPermission {
    
    [DMLLocationManager requestAuthorization];
    
}

@end
