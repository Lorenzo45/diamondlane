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

NSString * const DMLSplashViewControllerDoneOnboardingNotificationName = @"DMLSplashViewControllerDoneOnboardingNotificationName";

@interface DMLSplashViewController ()

@property (nonatomic, assign) BOOL presentedOnboardingViewController;

@property (nonatomic, weak) DMLHomeViewController *homeViewController;

@end

@implementation DMLSplashViewController

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    
    [[[self homeViewController] view] setFrame:[[self view] bounds]];
    
}

#pragma mark - Initialization

-(void)initializeApplication {
    
    ;
    
}

#pragma mark - Notifications

-(void)doneOnboardingNotification:(id)sender {
    
    [self showHomeViewController];
    
}

#pragma mark - View Controllers

-(void)showHomeViewController {
    
    if ([self homeViewController]) {
        
        return;
        
    }
    
    [self initializeApplication];
    
    DMLHomeViewController *homeViewController = [[DMLHomeViewController alloc] initWithNibName:nil bundle:nil];
    [self setHomeViewController:homeViewController];
    
    [self addChildViewController:homeViewController];
    [[homeViewController view] setFrame:[[self view] bounds]];
    [[self view] addSubview:[homeViewController view]];
    [homeViewController didMoveToParentViewController:self];
    
}

-(void)showOnboardingViewController {
    
    if ([self presentedOnboardingViewController]) {
        
        return;
        
    }
    [self setPresentedOnboardingViewController:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneOnboardingNotification:) name:DMLSplashViewControllerDoneOnboardingNotificationName object:nil];
    
    DMLOnboardingViewController *onboardingViewController = [[DMLOnboardingViewController alloc] initWithNibName:@"DMLOnboardingViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:onboardingViewController];
    [self presentViewController:navigationController animated:NO completion:nil];
    
}

@end
