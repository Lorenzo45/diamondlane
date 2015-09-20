//
//  DMLSetTimeViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-20.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLSetTimeViewController.h"

@interface DMLSetTimeViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation DMLSetTimeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.promptLabel.text = [NSString stringWithFormat:@"When do you leave on %@?", self.title];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.delegate didUpdateTime:self.datePicker.date];
    
}

@end
