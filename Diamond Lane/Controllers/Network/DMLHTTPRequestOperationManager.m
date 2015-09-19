//
//  DMLHTTPRequestOperationManager.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLUser.h"

#import "DMLHTTPRequestOperationManager.h"
#import "DMLJSONResponseSerializer.h"

NSString * const DMLRequestOperationManagerBaseURLString = @"http://52.11.211.211/";

NSString * const DMLRequestOperationManagerAuthenticationHeaderName = @"X-dml_auth_token";

@implementation DMLHTTPRequestOperationManager

+(instancetype)manager {
    
    id manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:DMLRequestOperationManagerBaseURLString]];
    [manager setResponseSerializer:[DMLJSONResponseSerializer serializer]];
    
    NSString * const authenticationToken = [[DMLUser me] authenticationToken];
    if (authenticationToken) {
        
        [[manager requestSerializer] setValue:authenticationToken forHTTPHeaderField:DMLRequestOperationManagerAuthenticationHeaderName];
        
    }
    return manager;
}

@end
