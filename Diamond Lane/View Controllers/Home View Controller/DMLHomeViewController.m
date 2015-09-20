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
#import "DMLEnRouteViewController.h"
#import "DMLCarpool.h"

@interface DMLHomeViewController ()

@property(strong, nonatomic) NSMutableArray *carpools;
@property(nonatomic) BOOL enRoute;
@property(strong, nonatomic) UIViewController *baseVC;

@end

@implementation DMLHomeViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [DMLCarpool fetchCarpoolsWithCompletionBlock:^(NSArray *carpools) {
            
            self.carpools = [carpools mutableCopy];
            
        } failedBlock:^(NSError *error) {
            
            NSLog(@"%@", error);
            
        }];
        
        self.enRoute = NO; // TODO: Fetch from server
        
    }
    return self;
    
}

- (void)setCarpools:(NSMutableArray *)carpools {
    
    _carpools = carpools;
    
    [self updateBaseViewController];
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

-(void)updateBaseViewController {
    
    if (self.carpools.count == 0 && ![self.baseVC isKindOfClass:[DMLNoCarpoolsViewController class]]) {
        
        self.baseVC = [[DMLNoCarpoolsViewController alloc] initWithNibName:@"DMLNoCarpoolsViewController" bundle:nil];
    
    } else if (!self.enRoute && ![self.baseVC isKindOfClass:[DMLCarpoolDetailViewController class]]) {
        
        self.baseVC = [[DMLCarpoolDetailViewController alloc] init];
    
    } else if (![self.baseVC isKindOfClass:[DMLEnRouteViewController class]]) {
        
        self.baseVC = [[DMLEnRouteViewController alloc] initWithNibName:@"DMLEnRouteViewController" bundle:nil];
    
    }
    
    self.baseVC.title = @"♦️ LANE";
    [self setViewControllers:@[self.baseVC]];
    
}

@end
