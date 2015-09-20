//
//  DMLHomeViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLHomeViewController.h"

#import "DMLNoCarpoolsViewController.h"
#import "DMLCarpoolDetailViewController.h"
#import "DMLCarpoolListViewController.h"
#import "DMLEnRouteViewController.h"
#import "DMLCarpool.h"

@interface DMLHomeViewController () <DMLNoCarpoolsViewControllerDelegate>

@property (nonatomic, assign, getter=isEnRoute) BOOL enRoute;

@property (strong, nonatomic) NSArray *carpools;
@property (nonatomic, weak) UIViewController *baseViewController;

@end

@implementation DMLHomeViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [self reloadCarpoolsInBackground:NO];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    ;
    
}

-(void)reloadCarpoolsInBackground:(BOOL)inBackground {
    
    [DMLCarpool fetchCarpoolsWithCompletionBlock:^(NSArray *carpools) {
        
        _carpools = carpools;
        [self refreshBaseViewController];
        
    } failedBlock:^(NSError *error) {
        
        NSLog(@"Failed to fetch carpools with completion block: %@",error);
        
    }];
    
}

-(void)refreshBaseViewController {
    
    if (![[self carpools] count]) {
        
        [self showNoCarpoolsViewController];
        
    } else if ([self isEnRoute]) {
        
        [self showEnRouteViewController];
        
    } else {
        
        [self showListViewController];
        
    }
    
}

#pragma mark - Child View Controllers

-(void)showNoCarpoolsViewController {
    
    if ([[self baseViewController] isKindOfClass:[DMLNoCarpoolsViewController class]]) {
        
        return;
        
    }
    
    DMLNoCarpoolsViewController *noCarpoolsViewController = [[DMLNoCarpoolsViewController alloc] initWithNibName:@"DMLNoCarpoolsViewController" bundle:nil];
    [noCarpoolsViewController setTitle:@"♦️ LANE"];
    [self setViewControllers:@[noCarpoolsViewController]];
    [self setBaseViewController:noCarpoolsViewController];
    
}

-(void)showEnRouteViewController {
    
    if ([[self baseViewController] isKindOfClass:[DMLEnRouteViewController class]]) {
        
        return;
        
    }
    
    DMLEnRouteViewController *detailViewController = [[DMLEnRouteViewController alloc] initWithNibName:@"DMLEnRouteViewController" bundle:nil];
    [detailViewController setTitle:@"♦️ LANE"];
    [self setViewControllers:@[detailViewController]];
    [self setBaseViewController:detailViewController];
    
}

-(void)showListViewController {
    
    if ([[self baseViewController] isKindOfClass:[DMLCarpoolListViewController class]]) {
        
        return;
        
    }
    
    DMLCarpoolListViewController *listViewController = [[DMLCarpoolListViewController alloc] initWithNibName:nil bundle:nil];
    listViewController.carpools = self.carpools;
    [listViewController setTitle:@"♦️ LANE"];
    [self setViewControllers:@[listViewController]];
    [self setBaseViewController:listViewController];
    
}

#pragma mark - DMLNoCarpoolsViewControllerDelegate

-(void)noCarpoolsViewControllerDidCreateCarpool:(DMLNoCarpoolsViewController *)createCarpoolViewController {
    
    [self reloadCarpoolsInBackground:YES];
    
}

@end
