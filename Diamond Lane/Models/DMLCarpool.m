//
//  DMLCarpool.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpool.h"
#import "DMLUser.h"

#import "DMLHTTPRequestOperationManager.h"
#import "DMLObjectStore.h"

#import "DMLModel+Updates.h"

NSString * const DMLCarpoolIdentifierKey = @"id";
NSString * const DMLCarpoolNameKey = @"name";
NSString * const DMLCarpoolMembersKey = @"members";

@implementation DMLCarpool

#pragma mark - Attributes

-(void)updateWithAttributes:(NSDictionary *)attributes {
    
    if ([self attributesKey:DMLCarpoolIdentifierKey canBeUpdatedFromAttributes:attributes]) {
        
        _identifier = [[attributes valueForKeyPath:DMLCarpoolIdentifierKey] integerValue];
        
    }
    
    if ([self attributesKey:DMLCarpoolNameKey canBeUpdatedFromAttributes:attributes]) {
        
        _name = [attributes valueForKeyPath:DMLCarpoolNameKey];
        
    }
    
    if ([self attributesKey:DMLCarpoolMembersKey canBeUpdatedFromAttributes:attributes]) {
        
        NSArray *membersAttributes = [attributes valueForKeyPath:DMLCarpoolMembersKey];
        NSMutableArray *members = [NSMutableArray array];
        for (NSDictionary *attributes in membersAttributes) {
            
            DMLUser *user = [DMLUser userWithAttributes:attributes];
            [members addObject:user];
            
        }
        _members = [NSArray arrayWithArray:members];
        
    }
    
}

#pragma mark - Carpools

+(void)createCarpoolWithName:(NSString *)name completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *parameters = @{ @"name" : name ?: @"dank memes" };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/carpools/create.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        completionBlock ? completionBlock() : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

+(void)fetchCarpoolsWithCompletionBlock:(void (^)(NSArray *carpools))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    [[DMLHTTPRequestOperationManager manager] GET:@"api/carpools/fetch.php" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        NSMutableArray *carpools = [NSMutableArray array];
        for (NSDictionary *attributes in results) {
            
            DMLCarpool *carpool = [DMLCarpool carpoolWithAttributes:attributes];
            [carpools addObject:carpool];
            
        }
        completionBlock ? completionBlock([NSArray arrayWithArray:carpools]) : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

#pragma mark - Location

-(void)reportLeavingAsDriverWithCompletionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *attributes = @{ @"carpool_id" : @([self identifier]) };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/locations/left_home.php" parameters:attributes success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        completionBlock ? completionBlock() : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

-(void)reportArrivingAt:(DMLUser *)user completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *attributes = @{ @"carpool_id" : @([self identifier]), @"arrival_id" : @([user identifier]) };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/locations/arrived.php" parameters:attributes success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        completionBlock ? completionBlock() : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

#pragma mark - Members

-(void)refreshMembersWithCompletionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *attributes = @{ @"carpool_id" : @([self identifier]) };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/carpools/fetch_members.php" parameters:attributes success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        [self updateWithAttributes:@{ DMLCarpoolMembersKey : results }];
        
        completionBlock ? completionBlock() : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

#pragma mark - Persistent Object

-(id)persistentObjectIdentifier {
    
    return [DMLCarpool perstentObjectIdentifierFromIdentifier:[self identifier]];
    
}

+(NSInteger)identifierFromAttributes:(NSDictionary *)attributes {
    
    return [[attributes valueForKeyPath:DMLCarpoolIdentifierKey] integerValue];
    
}

+(id)perstentObjectIdentifierFromIdentifier:(NSInteger)identifier {
    
    return @(identifier);
    
}

#pragma mark - Class Methods

+(instancetype)carpoolWithAttributes:(NSDictionary *)attributes {
    
    id identifier = [DMLCarpool perstentObjectIdentifierFromIdentifier:[self identifierFromAttributes:attributes]];
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

@end
