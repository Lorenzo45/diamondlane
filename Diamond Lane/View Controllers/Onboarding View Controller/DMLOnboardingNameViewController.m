//
//  DMLOnboardingNameViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingNameViewController.h"

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    if ([self.nameInputTextView.text isEqual:@""]) {
        
        self.nameInputTextView.text = @"name";
        
    }
    
}

- (IBAction)continueButtonTapped:(id)sender {
    
    // working on error display
    
    if ([self.nameInputTextView.text isEqual:@"name"] || [self.nameInputTextView.text isEqual:@""]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.nameInputTextView.textColor = [UIColor redColor];
        
        } completion:^(BOOL finished) {
            
        }];
         
    }
}

@end
