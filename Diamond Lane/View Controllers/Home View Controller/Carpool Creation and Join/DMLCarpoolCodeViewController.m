//
//  DMLCarpoolCodeViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolCodeViewController.h"

@interface DMLCarpoolCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation DMLCarpoolCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Code";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)copyButtonPressed {
    
    [UIPasteboard generalPasteboard].string = self.codeTextField.text;
    
}

- (void)doneButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
