//
//  DMLJSONResponseSerializer.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLJSONResponseSerializer.h"

@implementation DMLJSONResponseSerializer

-(BOOL)validateResponse:(nullable NSHTTPURLResponse *)response data:(nullable NSData *)data error:(NSError * __nullable __autoreleasing *)error {
    
    BOOL result = [super validateResponse:response data:data error:error];
    if (!result) {
        
        NSDictionary *jsonError = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *errorString = jsonError[@"error"];
        if (errorString) {
            
            NSError *errorCopy = *error;
            NSMutableDictionary *userInfo = [[*error userInfo] mutableCopy];
            userInfo[NSLocalizedDescriptionKey] = errorString;
            *error = [NSError errorWithDomain:[errorCopy domain] code:[errorCopy code] userInfo:userInfo];
            
        }
        
    }
    return result;
    
}

@end
