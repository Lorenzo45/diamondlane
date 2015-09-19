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

-(void)setString:(NSString *)string forKey:(NSString *)key;
-(NSString *)stringForKey:(NSString *)key;

-(void)setObject:(id <NSCoding>)object forKey:(NSString *)key;
-(id)objectForKey:(NSString *)key;

-(void)removeItemForKey:(NSString *)key;

+(instancetype)sharedInstance;

@end
