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

@end

@implementation DMLCreateCarpoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Create";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueButtonPressed {
    
    [self.navigationController pushViewController:[[DMLCarpoolCodeViewController alloc] init] animated:YES];
    
}

- (void)cancelButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
