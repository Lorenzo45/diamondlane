//
//  DMLCarpoolCodeViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolCodeViewController.h"

@interface DMLCarpoolCodeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;


@end

@implementation DMLCarpoolCodeViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Code";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
        [self.navigationItem setHidesBackButton:YES];
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [self.codeButton setTitle:self.code forState:UIControlStateNormal];
    
    [self.codeButton setTitleColor:[UIColor dml_grayColor] forState:UIControlStateNormal];
    
    self.tapPromptLabel.textColor = [UIColor dml_grayColor];
    
}

- (IBAction)copyButtonPressed {
    
    [UIPasteboard generalPasteboard].string = self.codeButton.titleLabel.text;
    
}

- (void)doneButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
