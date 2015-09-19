//
//  DMLJoinViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLJoinViewController.h"

@interface DMLJoinViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation DMLJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Join";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cancelButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
