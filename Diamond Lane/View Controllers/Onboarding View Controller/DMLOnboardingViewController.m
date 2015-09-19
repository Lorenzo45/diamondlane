//
//  DMLOnboardingViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingViewController.h"

@interface DMLOnboardingViewController ()

@end

@implementation DMLOnboardingViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

- (IBAction)goButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"NameSegue" sender:sender];
    
}

@end
