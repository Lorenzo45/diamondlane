//
//  DMLCreateCarpoolViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCreateCarpoolViewController.h"

#import "DMLCarpoolCodeViewController.h"

@interface DMLCreateCarpoolViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *shiftView;

@property (nonatomic) BOOL keyboardIsVisible;

@end

@implementation DMLCreateCarpoolViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Create";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBegan:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardEnded:) name:UIKeyboardWillHideNotification object:nil];
    
    self.keyboardIsVisible = NO;

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.view endEditing:YES];
    
}

- (IBAction)continueButtonPressed {
    
    [self.navigationController pushViewController:[[DMLCarpoolCodeViewController alloc] init] animated:YES];
    
}

- (void)cancelButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
        
        float shiftConstant = ((keyboardFrameBeginRect.size.height) / 2) - self.navigationController.navigationBar.frame.size.height;
        
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
