//
//  DMLSplashViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLHomeViewController.h"
#import "DMLOnboardingViewController.h"
#import "DMLSplashViewController.h"

#import "DMLUser.h"

@interface DMLSplashViewController ()

@property (nonatomic, assign) BOOL presentedOnboardingViewController;

@property (nonatomic, weak) UIViewController *childViewController;
@property (nonatomic, weak) DMLHomeViewController *homeViewController;

@end

@implementation DMLSplashViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor redColor]];
    
    if ([DMLUser me]) {
        
        [self showHomeViewController];
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (![DMLUser me]) {
        
        [self showOnboardingViewController];
        
    }
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [[[self childViewController] view] setFrame:[[self view] bounds]];
    
}

#pragma mark - Initialization

-(void)initializeApplication {
    
    ;
    
}

#pragma mark - View Controllers

-(void)showHomeViewController {
    
    if ([self homeViewController]) {
        
        return;
        
    }
    
    [self initializeApplication];
    
    DMLHomeViewController *homeViewController = [[DMLHomeViewController alloc] initWithNibName:@"DMLHomeViewController" bundle:nil];
    [self setHomeViewController:homeViewController];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [self setChildViewController:navigationController];
    
    [self addChildViewController:navigationController];
    [[navigationController view] setFrame:[[self view] bounds]];
    [[self view] addSubview:[navigationController view]];
    [navigationController didMoveToParentViewController:self];
    
}

-(void)showOnboardingViewController {
    
    if ([self presentedOnboardingViewController]) {
        
        return;
        
    }
    [self setPresentedOnboardingViewController:YES];
    
    DMLOnboardingViewController *onboardingViewController = [[DMLOnboardingViewController alloc] initWithNibName:@"DMLOnboardingViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:onboardingViewController];
    [self presentViewController:navigationController animated:NO completion:nil];
    
}

@end
