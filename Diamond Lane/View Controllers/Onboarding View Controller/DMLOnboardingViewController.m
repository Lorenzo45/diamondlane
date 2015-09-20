//
//  DMLOnboardingViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingViewController.h"
#import "DMLOnboardingNameViewController.h"

@interface DMLOnboardingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@property (weak, nonatomic) IBOutlet UIImageView *diamondImageView;

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
    
    self.beginButton.backgroundColor = [UIColor dml_tintColor];
    self.beginButton.layer.cornerRadius = 6;
    
    self.diamondImageView.clipsToBounds = YES;
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}

- (IBAction)goButtonTapped:(id)sender {
    
    DMLOnboardingNameViewController *nameViewController = [[DMLOnboardingNameViewController alloc] initWithNibName:@"DMLOnboardingNameViewController" bundle:nil];
    [[self navigationController] pushViewController:nameViewController animated:YES];
    
}

@end
