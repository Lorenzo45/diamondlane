//
//  DMLJoinViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLJoinViewController.h"

@interface DMLJoinViewController () <UITextFieldDelegate>

#import "DMLcarpool.h"

@property (nonatomic, readonly, strong) UILabel *codePromptLabel;
@property (nonatomic, readonly, strong) UITextField *codeTextField;
@property (nonatomic, readonly, strong) UIView* shiftView;
@property (nonatomic, readonly, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic) BOOL keyboardIsVisible;

@end

@implementation DMLJoinViewController
@synthesize codeTextField=_codeTextField;
-(UITextField *)codeTextField {
    
    if (!_codeTextField) {
        
        _codeTextField = [[UITextField alloc] init];
        [_codeTextField setBorderStyle:UITextBorderStyleNone];
        [_codeTextField setDelegate:self];
        [_codeTextField setReturnKeyType:UIReturnKeyGo];
        [_codeTextField setTextColor:[UIColor dml_grayColor]];
        [_codeTextField setTextAlignment:NSTextAlignmentCenter];
        [_codeTextField setPlaceholder:@"code"];
        [_codeTextField setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightLight]];
        [_codeTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_codeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [[self view] addSubview:_codeTextField];
        
    }
    return _codeTextField;
    
}

@synthesize codePromptLabel=_codePromptLabel;
-(UILabel *)codePromptLabel {
    
    if (!_codePromptLabel) {
        
        _codePromptLabel = [[UILabel alloc] init];
        [_codePromptLabel setTextAlignment:NSTextAlignmentCenter];
        [_codePromptLabel setTextColor:[UIColor dml_grayColor]];
        [_codePromptLabel setBackgroundColor:[UIColor clearColor]];
        [_codePromptLabel setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightThin]];
        [_codePromptLabel setNumberOfLines:0];
        [_codePromptLabel setText:@"Aight rat, enter a code to join some shit carpool."];
        [[self view] addSubview:_codePromptLabel];
        
    }
    return _codePromptLabel;
    
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Join";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
        
    }
    return self;
    
}

- (void)viewDidLoad {
    
    // setup view heirarchy
    
    [self codePromptLabel];
    [self codeTextField];
    [self shiftView];
    
    // begin
    
    [[self codeTextField] becomeFirstResponder];
    
}

@synthesize activityIndicatorView=_activityIndicatorView;
-(UIActivityIndicatorView *)activityIndicatorView {
    
    if (!_activityIndicatorView) {
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [[self view] addSubview:_activityIndicatorView];
        
    }
    return _activityIndicatorView;
    
}

-(void)dealloc {
    
    ;
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat const padding = 32.0;
    
    [[self codeTextField] setFrame:CGRectMake(0, (CGRectGetHeight([[self view] bounds]) - 64) / 2.0, CGRectGetWidth([[self view] bounds]), 64)];
    [[self codePromptLabel] setFrame:CGRectMake(padding, padding, CGRectGetWidth([[self view] bounds]) - padding * 2, CGRectGetMinY([[self codeTextField] frame]) - padding * 2.0)];
    [[self activityIndicatorView] setFrame:CGRectMake(0, CGRectGetMaxY([[self codeTextField] frame]) + 16.0, CGRectGetWidth([[self view] bounds]), 20)];
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
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

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self continueButtonPressed];
    return NO;
    
}

@end
