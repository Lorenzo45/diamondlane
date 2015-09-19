//
//  DMLHomeViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLHomeViewController.h"

#import "DMLNoCarpoolsViewController.h"
#import "DMLCarpoolListViewController.h"
#import "DMLEnRouteViewController.h"

@interface DMLHomeViewController ()

@property(strong, nonatomic) NSMutableArray *carpools;
@property(nonatomic) BOOL enRoute;
@property(strong, nonatomic) UIViewController *baseVC;

@end

@implementation DMLHomeViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.carpools = [@[@""] mutableCopy]; // TODO: Fetch from server
        self.enRoute = YES; // TODO: Fetch from server
        [self updateBaseViewController];
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

-(void)updateBaseViewController {
    
    if ((self.carpools == nil || self.carpools.count == 0) && ![self.baseVC isKindOfClass:[DMLNoCarpoolsViewController class]]) {
        
        self.baseVC = [[DMLNoCarpoolsViewController alloc] initWithNibName:@"DMLNoCarpoolsViewController" bundle:nil];
    
    } else if (!self.enRoute && ![self.baseVC isKindOfClass:[DMLCarpoolListViewController class]]) {
        
        self.baseVC = [[DMLCarpoolListViewController alloc] initWithNibName:@"DMLCarpoolListViewController" bundle:nil];
    
    } else if (![self.baseVC isKindOfClass:[DMLEnRouteViewController class]]) {
        
        self.baseVC = [[DMLEnRouteViewController alloc] initWithNibName:@"DMLEnRouteViewController" bundle:nil];
    
    }
    
    self.baseVC.title = @"♦️ LANE";
    [self setViewControllers:@[self.baseVC]];
    
}

@end
