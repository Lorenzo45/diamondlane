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
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *namePromptLabel;
@property (weak, nonatomic) IBOutlet UIView* shiftView;

@property (nonatomic) BOOL keyboardIsVisible;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBegan:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardEnded:) name:UIKeyboardWillHideNotification object:nil];
    
    self.keyboardIsVisible = NO;
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    
}

- (IBAction)continueButtonTapped:(id)sender {
    
    NSString *name = [[self nameInputTextView] text];
    if ([name length] != 0) {
        
        [[self continueButton] setAlpha:0.5];
        [[self continueButton] setUserInteractionEnabled:NO];

        [DMLUser createUserWithName:name completionBlock:^{
            
            [[self continueButton] setAlpha:1.0];
            [[self continueButton] setUserInteractionEnabled:YES];
            
            DMLOnboardingEnablerViewController *enablerViewController = [[DMLOnboardingEnablerViewController alloc] initWithNibName:@"DMLOnboardingEnablerViewController" bundle:nil];
            [[self navigationController] pushViewController:enablerViewController animated:YES];
            
        } failedBlock:^(NSError *error) {
            
            [[self continueButton] setAlpha:1.0];
            [[self continueButton] setUserInteractionEnabled:YES];
            
            UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ;
            }];
            
            [errorAlert addAction:defaultAction];
            [self presentViewController:errorAlert animated:YES completion:nil];
            
        }];
        
    }
}

- (void)keyboardBegan:(NSNotification *)notification
{
    if(!self.keyboardIsVisible) {
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:[[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue]];
        [UIView setAnimationCurve:[[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView commitAnimations];
        
        float shiftConstant = (keyboardFrameBeginRect.size.height) / 2;
        
        self.shiftView.transform = CGAffineTransformMakeTranslation(0, -shiftConstant);
        
        self.keyboardIsVisible = YES;
        
    }
}

- (void)keyboardEnded:(NSNotification *)notification {
    
    if(self.keyboardIsVisible) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:[[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue]];
        [UIView setAnimationCurve:[[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView commitAnimations];
        
        self.shiftView.transform = CGAffineTransformIdentity;
        
        self.keyboardIsVisible = NO;
        
    }
    
}

@end
