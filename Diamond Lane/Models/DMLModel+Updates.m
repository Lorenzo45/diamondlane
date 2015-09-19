//
//  DMLModel+Updates.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLModel+Updates.h"

@implementation NSObject (DMLModelUpdates)

-(BOOL)attributesKey:(NSString *)attributesKey canBeUpdatedFromAttributes:(NSDictionary *)attributes {
    
    id object = [attributes valueForKeyPath:attributesKey];
    if (!object) {
        
        return NO;
        
    }
    if (object == [NSNull null]) {
        
        return NO;
        
    }
    return YES;
    
}

@end
