//
//  DMLJoinViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLJoinViewController.h"

#import "DMLcarpool.h"

@interface DMLJoinViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView* shiftView;

@property (nonatomic) BOOL keyboardIsVisible;

@end

@implementation DMLJoinViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Join";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
        
    }
    return self;
    
}

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBegan:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardEnded:) name:UIKeyboardWillHideNotification object:nil];
    
    self.keyboardIsVisible = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.view endEditing:YES];
    
}

- (IBAction)continueButtonPressed {
    
    [DMLCarpool joinCarpoolWithCode:self.codeTextField.text completionBlock:^{
        [self.delegate joinCarpoolViewControllerDidCreateCarpool:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failedBlock:^(NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
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
