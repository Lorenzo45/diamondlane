//
//  DMLNoCarpoolsViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLNoCarpoolsViewController.h"

#import "DMLJoinViewController.h"
#import "DMLCreateCarpoolViewController.h"
#import "DMLJoinViewController.h"

@interface DMLNoCarpoolsViewController () <DMLCreateCarpoolViewControllerDelegate, DMLJoinCarpoolViewControllerDelegate>

@end

@implementation DMLNoCarpoolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinButtonPressed {
    
    DMLJoinViewController *joinViewController = [[DMLJoinViewController alloc] init];
    [joinViewController setDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:joinViewController];
    [self presentViewController:navController  animated:YES completion:nil];
    
}

- (IBAction)createButtonPressed {
    
    DMLCreateCarpoolViewController *createCarpoolViewController = [[DMLCreateCarpoolViewController alloc] init];
    [createCarpoolViewController setDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createCarpoolViewController];
    [self presentViewController:navController  animated:YES completion:nil];
    
}

#pragma mark - DMLCreateCarpoolViewControllerDelegate

-(void)createCarpoolViewControllerDidCreateCarpool:(DMLCreateCarpoolViewController *)createCarpoolViewController {
    
    if ([[self delegate] respondsToSelector:@selector(noCarpoolsViewControllerDidCreateCarpool:)]) {
        
        [[self delegate] noCarpoolsViewControllerDidCreateCarpool:self];
        
    }
    
}

#pragma mark - DMLJoinCarpoolViewControllerDelegate

-(void)joinCarpoolViewControllerDidCreateCarpool:(DMLJoinViewController *)joinCarpoolViewController {
    
    if ([[self delegate] respondsToSelector:@selector(noCarpoolsViewControllerDidCreateCarpool:)]) {
        
        [[self delegate] noCarpoolsViewControllerDidCreateCarpool:self];
        
    }
    
}

@end
