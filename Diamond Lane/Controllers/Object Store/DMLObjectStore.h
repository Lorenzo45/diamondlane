//
//  DMLObjectStore.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMLPersistentObject

@required
-(id)persistentObjectIdentifier;

+(NSInteger)identifierFromAttributes:(NSDictionary *)attributes;
+(id)perstentObjectIdentifierFromIdentifier:(NSInteger)identifier;

@end

@interface DMLObjectStore : NSObject

-(void)saveObject:(id <DMLPersistentObject>)object class:(Class)class;
-(id)objectForIdentifier:(id)identifier class:(Class)class;

+(instancetype)sharedObjectStore;

@end