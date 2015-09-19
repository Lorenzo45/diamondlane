//
//  DMLNotificationManager.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLNotificationManager.h"

@implementation DMLNotificationManager



#pragma mark - Class Methods

+(instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!sharedInstance) {
            
            sharedInstance = [[[self class] alloc] init];
            
        }
        
    });
    return sharedInstance;
    
}

@end
