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

@property (weak, nonatomic) IBOutlet UITextView *nameInputTextView;

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

-(void)textViewDidBeginEditing:(id)sender {
    
    self.nameInputTextView.textColor = [UIColor blackColor];
    
    if ([self.nameInputTextView.text isEqual:@"name"]) {
        
        self.nameInputTextView.text = @"";
        
    }
    
}

- (void)textViewDidChange:(id)sender {
    
    // Limits the textfield to the bounds of the rectangle
    
    NSUInteger maxNumberOfLines = 1;
    NSUInteger numLines = self.nameInputTextView.contentSize.height / self.nameInputTextView.font.lineHeight;
    
    if (numLines > maxNumberOfLines) {
        
        self.nameInputTextView.text = [self.nameInputTextView.text substringToIndex:self.nameInputTextView.text.length - 1];
        
    }
    
}

- (IBAction)continueButtonTapped:(id)sender {
    
    NSString *name = [[self nameInputTextView] text];
    if ([name length] == 0) {
        
        self.nameInputTextView.textColor = [UIColor redColor];
         
    } else {
        
        [DMLUser createUserWithName:name completionBlock:^{
            
            DMLOnboardingEnablerViewController *enablerViewController = [[DMLOnboardingEnablerViewController alloc] initWithNibName:@"DMLOnboardingEnablerViewController" bundle:nil];
            [[self navigationController] pushViewController:enablerViewController animated:YES];
            
        } failedBlock:^(NSError *error) {
            
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
            
        }];
        
    }
}

@end
