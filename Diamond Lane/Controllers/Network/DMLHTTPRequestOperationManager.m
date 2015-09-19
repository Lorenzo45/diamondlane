//
//  DMLHTTPRequestOperationManager.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLHTTPRequestOperationManager.h"

NSString * const DMLRequestOperationManagerBaseURLString = @"http://diamondlaneapp.co/";

@implementation DMLHTTPRequestOperationManager

+(instancetype)manager {
    
    id manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:DMLRequestOperationManagerBaseURLString]];
    return manager;
}

@end
