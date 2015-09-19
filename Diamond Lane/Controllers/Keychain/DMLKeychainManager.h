//
//  KeychainWrapper.h
//  Apple's Keychain Services Programming Guide
//
//  Created by Tim Mitra on 11/17/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface DMLKeychainManager : NSObject

-(void)setObject:(id)object forKey:(id)key;
-(id)objectForKey:(id)key;

+(instancetype)sharedInstance;

@end
