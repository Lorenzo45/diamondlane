//
//  DMLOnboardingNameViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingNameViewController.h"
#import "DMLOnboardingEnablerViewController.h"

#import "DMLUser.h"

@interface DMLOnboardingNameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInputTextView;

@end

@implementation DMLOnboardingNameViewController

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self.nameInputTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self.nameInputTextView];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

- (IBAction)continueButtonTapped:(id)sender {
    
    NSString *name = [[self nameInputTextView] text];
    if ([name length] != 0) {

        [DMLUser createUserWithName:name completionBlock:^{
            
            NSLog(@"oof");
            
            DMLOnboardingEnablerViewController *enablerViewController = [[DMLOnboardingEnablerViewController alloc] initWithNibName:@"DMLOnboardingEnablerViewController" bundle:nil];
            [[self navigationController] pushViewController:enablerViewController animated:YES];
            
        } failedBlock:^(NSError *error) {
            
            UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }];
            
            [errorAlert addAction:defaultAction];
            [self presentViewController:errorAlert animated:YES completion:nil];
            
        }];
        
    }
}

@end
