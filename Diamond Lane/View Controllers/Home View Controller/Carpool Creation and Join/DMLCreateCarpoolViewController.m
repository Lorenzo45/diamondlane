//
//  DMLCreateCarpoolViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCreateCarpoolViewController.h"

#import "DMLCarpoolCodeViewController.h"
#import "DMLCarpool.h"

@interface DMLCreateCarpoolViewController () <UITextFieldDelegate>

@property (nonatomic, readonly, strong) UITextField *codeTextField;
@property (nonatomic, readonly, strong) UIView *shiftView;
@property (nonatomic, readonly, strong) UILabel *namePromptLabel;
@property (nonatomic, readonly, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic) BOOL keyboardIsVisible;

@end

@implementation DMLCreateCarpoolViewController
@synthesize codeTextField=_codeTextField;
-(UITextField *)codeTextField {
    
    if (!_codeTextField) {
        
        _codeTextField = [[UITextField alloc] init];
        [_codeTextField setBorderStyle:UITextBorderStyleNone];
        [_codeTextField setDelegate:self];
        [_codeTextField setReturnKeyType:UIReturnKeyGo];
        [_codeTextField setTextColor:[UIColor dml_grayColor]];
        [_codeTextField setTextAlignment:NSTextAlignmentCenter];
        [_codeTextField setPlaceholder:@"carpool name"];
        [_codeTextField setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightLight]];
        [_codeTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_codeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [[self view] addSubview:_codeTextField];
        
    }
    return _codeTextField;
    
}

@synthesize namePromptLabel=_namePromptLabel;
-(UILabel *)namePromptLabel {
    
    if (!_namePromptLabel) {
        
        _namePromptLabel = [[UILabel alloc] init];
        [_namePromptLabel setTextAlignment:NSTextAlignmentCenter];
        [_namePromptLabel setTextColor:[UIColor dml_grayColor]];
        [_namePromptLabel setBackgroundColor:[UIColor clearColor]];
        [_namePromptLabel setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightThin]];
        [_namePromptLabel setNumberOfLines:0];
        [_namePromptLabel setText:@"Please create a carpool name."];
        [[self view] addSubview:_namePromptLabel];
        
    }
    return _namePromptLabel;
    
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

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Create";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    // setup view heirarchy
    
    [self namePromptLabel];
    [self codeTextField];
    [self shiftView];
    
    // begin
    
    [[self codeTextField] becomeFirstResponder];

}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat const padding = 32.0;
    
    [[self codeTextField] setFrame:CGRectMake(0, (CGRectGetHeight([[self view] bounds]) - 64) / 2.0, CGRectGetWidth([[self view] bounds]), 64)];
    [[self namePromptLabel] setFrame:CGRectMake(padding, padding, CGRectGetWidth([[self view] bounds]) - padding * 2, CGRectGetMinY([[self codeTextField] frame]) - padding * 2.0)];
    [[self activityIndicatorView] setFrame:CGRectMake(0, CGRectGetMaxY([[self codeTextField] frame]) + 16.0, CGRectGetWidth([[self view] bounds]), 20)];
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.view endEditing:YES];
    
}

- (IBAction)createButtonPressed {
    
    if (self.codeTextField.text.length > 0) {
        
        [DMLCarpool createCarpoolWithName:self.codeTextField.text completionBlock:^(NSString *code){
            
            DMLCarpoolCodeViewController* carpoolCodeViewController = [[DMLCarpoolCodeViewController alloc] init];
            [carpoolCodeViewController setCode:code];
            [self.navigationController pushViewController:carpoolCodeViewController animated:YES];

            if ([[self delegate] respondsToSelector:@selector(createCarpoolViewControllerDidCreateCarpool:)]) {
                
                [[self delegate] createCarpoolViewControllerDidCreateCarpool:self];
                
            }
            
        } failedBlock:^(NSError *error) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        
        }];
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Carpool name cannot be empty!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

- (void)cancelButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self createButtonPressed];
    return NO;
    
}

@end
