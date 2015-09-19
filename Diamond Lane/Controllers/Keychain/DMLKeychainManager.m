//
//  DMLDMLKeychainWrapper.h
//  Apple's Keychain Services Programming Guide
//
//  Created by Tim Mitra on 11/17/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "DMLKeychainManager.h"

#import <UICKeyChainStore/UICKeyChainStore.h>

NSString * const DMLKeychainServiceString = @"co.diamondlaneapp.diamondlane";

@implementation DMLKeychainManager

#pragma mark - Keychain Manipulation

-(void)setString:(NSString *)string forKey:(NSString *)key {
    
    UICKeyChainStore *keychainStore = [self newKeychainStore];
    [keychainStore setString:string forKey:key];
    
}

-(NSString *)stringForKey:(NSString *)key {
    
    UICKeyChainStore *keychainStore = [self newKeychainStore];
    return [keychainStore stringForKey:key];
    
}

-(void)setObject:(id <NSCoding>)object forKey:(NSString *)key {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    UICKeyChainStore *keychainStore = [self newKeychainStore];
    [keychainStore setData:data forKey:key];
    
}

-(id)objectForKey:(NSString *)key {
    
    UICKeyChainStore *keychainStore = [self newKeychainStore];
    NSData *data = [keychainStore dataForKey:key];
    if (!data) {
        
        return nil;
        
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

-(void)removeItemForKey:(NSString *)key {
    
    UICKeyChainStore *keychainStore = [self newKeychainStore];
    [keychainStore removeItemForKey:key];
    
}

#pragma mark - Keychain Store

-(UICKeyChainStore *)newKeychainStore {
    
    UICKeyChainStore *keychainStore = [[UICKeyChainStore alloc] initWithService:DMLKeychainServiceString];
    [keychainStore setSynchronizable:YES];
    return keychainStore;
    
}

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
