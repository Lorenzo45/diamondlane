//
//  DMLObjectStore.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLObjectStore.h"

@interface DMLObjectStore ()

@property (nonatomic, readonly, strong) NSMutableDictionary *dictionary;

@end

@implementation DMLObjectStore

@synthesize dictionary=_dictionary;
-(NSMutableDictionary *)dictionary {
    
    if (!_dictionary) {
        
        _dictionary = [[NSMutableDictionary alloc] init];
        
    }
    return _dictionary;
    
}

-(void)saveObject:(id <DMLPersistentObject>)object class:(Class)class {
    
    id identifier = [object persistentObjectIdentifier];
    id classIdentifier = [self identifierFromClass:class];
    
    NSMutableDictionary *objects = [self dictionary][classIdentifier];
    if (!objects) {
        
        objects = [NSMutableDictionary dictionary];
        [self dictionary][classIdentifier] = objects;
        
    }
    
    objects[identifier] = object;
    
}

-(id)objectForIdentifier:(id)identifier class:(Class)class {
    
    id classIdentifier = [self identifierFromClass:class];
    
    NSMutableDictionary *objects = [self dictionary][classIdentifier];
    if (!objects) {
        
        return nil;
        
    }
    
    id object = objects[identifier];
    return object;
    
}

#pragma mark - Helper Methods

-(id)identifierFromClass:(Class)class {
    
    return NSStringFromClass(class);
    
}

#pragma mark - Class Methods

+(instancetype)sharedObjectStore {
    
    static id objectStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!objectStore) {
            
            objectStore = [[[self class] alloc] init];
            
        }
        
    });
    return objectStore;
    
}

@end
