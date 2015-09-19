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

@interface DMLNoCarpoolsViewController ()

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
    
    UINavigationController *navController = [[UINavigationController alloc] init];
    navController.viewControllers = @[[[DMLJoinViewController alloc] init]];
    [self presentViewController:navController  animated:YES completion:nil];
    
}

- (IBAction)createButtonPressed {
    
    UINavigationController *navController = [[UINavigationController alloc] init];
    navController.viewControllers = @[[[DMLCreateCarpoolViewController alloc] init]];
    [self presentViewController:navController  animated:YES completion:nil];
    
}

@end
