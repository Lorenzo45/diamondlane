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

@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UILabel *addCarpoolLabel;

@end

@implementation DMLNoCarpoolsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.joinButton.backgroundColor = [UIColor dml_tintColor];
    self.joinButton.layer.cornerRadius = 6;
    
    self.createButton.backgroundColor = [UIColor dml_tintColor];
    self.createButton.layer.cornerRadius = 6;
    
    self.addCarpoolLabel.textColor = [UIColor dml_grayColor];
    self.addCarpoolLabel.font = [UIFont systemFontOfSize:30.0 weight:UIFontWeightLight];
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
