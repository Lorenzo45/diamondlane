//
//  DMLUser.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLUser.h"

#import "DMLHTTPRequestOperationManager.h"
#import "DMLKeychainWrapper.h"
#import "DMLObjectStore.h"

#import "DMLModel+Updates.h"

NSString * const DMLUserAuthenticationTokenKey = @"authentication_token";
NSString * const DMLUserIdentifierKey = @"id";

@implementation DMLUser



#pragma mark - Attributes

-(void)updateWithAttributes:(NSDictionary *)attributes {
    
    if ([self attributesKey:DMLUserAuthenticationTokenKey canBeUpdatedFromAttributes:attributes]) {
        
        _authenticationToken = [attributes valueForKeyPath:DMLUserAuthenticationTokenKey];
        
    }
    
    if ([self attributesKey:DMLUserIdentifierKey canBeUpdatedFromAttributes:attributes]) {
        
        _identifier = [[attributes valueForKeyPath:DMLUserIdentifierKey] integerValue];
        
    }
    
}

#pragma mark - Creation

+(void)createUserWithName:(NSString *)name completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *attributes = @{ @"name" : name ?: @"dank memer", @"device_id" : [self deviceID] };
    [[DMLHTTPRequestOperationManager manager] GET:@"api/user/create.php" parameters:attributes success:^(AFHTTPRequestOperation *operation, NSDictionary *attributes) {
        
        DMLUser *user = [DMLUser userWithAttributes:attributes];
        _me = user;
        
        DMLKeychainWrapper *keychainWrapper = [[DMLKeychainWrapper alloc] init];
        [DMLUser saveAttributes:user toKeychain:keychainWrapper];
        
        completionBlock ? completionBlock() : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

#pragma mark - Device

+(NSString *)deviceID {
    
    NSUUID *identifierForVendor = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [identifierForVendor UUIDString];
    return deviceID;
    
}

#pragma mark - Keychain

+(NSDictionary *)attributesFromKeychain:(DMLKeychainWrapper *)keychain {
    
    id authenticationToken = [keychain myObjectForKey:DMLUserAuthenticationTokenKey];
    id identifier = [keychain myObjectForKey:DMLUserIdentifierKey];
    if (!authenticationToken || !identifier) {
        
        return nil;
        
    }
    return @{ DMLUserAuthenticationTokenKey : authenticationToken, DMLUserIdentifierKey : identifier };
    
}

+(void)saveAttributes:(DMLUser *)user toKeychain:(DMLKeychainWrapper *)keychain {
    
    id authenticationToken = [user authenticationToken];
    id identifier = [self perstentObjectIdentifierFromIdentifier:[user identifier]];
    if (!authenticationToken || !identifier) {
        
        return;
        
    }
    [keychain mySetObject:authenticationToken forKey:DMLUserAuthenticationTokenKey];
    [keychain mySetObject:identifier forKey:DMLUserIdentifierKey];
    [keychain writeToKeychain];
    
}

#pragma mark - Persistent Object

-(id)persistentObjectIdentifier {
    
    return [DMLUser perstentObjectIdentifierFromIdentifier:[self identifier]];
    
}

+(NSInteger)identifierFromAttributes:(NSDictionary *)attributes {
    
    return [[attributes valueForKeyPath:DMLUserIdentifierKey] integerValue];
    
}

+(id)perstentObjectIdentifierFromIdentifier:(NSInteger)identifier {
    
    return @(identifier);
    
}

#pragma mark - Class Methods

+(DMLUser *)userWithAttributes:(NSDictionary *)attributes {
    
    id identifier = [DMLUser perstentObjectIdentifierFromIdentifier:[self identifierFromAttributes:attributes]];
    id item = [[DMLObjectStore sharedObjectStore] objectForIdentifier:identifier class:[self class]];
    if (!item) {
        
        item = [[[self class] alloc] init];
        [item updateWithAttributes:attributes];
        [[DMLObjectStore sharedObjectStore] saveObject:item class:[self class]];
        
    } else {
        
        [item updateWithAttributes:attributes];
        
    }
    
    return item;
    
}

static DMLUser *_me = nil;
+(instancetype)me {
    
    if (!_me) {
        
        DMLKeychainWrapper *keychainWrapper = [[DMLKeychainWrapper alloc] init];
        NSDictionary *attributes = [self attributesFromKeychain:keychainWrapper];
        if (attributes) {
            
            _me = [DMLUser userWithAttributes:attributes];
            
        }
        
    }
    return _me;
    
}

@end
