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
NSString * const DMLCarpoolCodeKey = @"code";
NSString * const DMLCarpoolNameKey = @"name";
NSString * const DMLCarpoolMembersKey = @"members";

NSString * const DMLCarpoolMondayStartingTimeKey = @"mon_time";
NSString * const DMLCarpoolTuesdayStartingTimeKey = @"tues_time";
NSString * const DMLCarpoolWednesdayStartingTimeKey = @"wed_time";
NSString * const DMLCarpoolThursdayStartingTimeKey = @"thurs_time";
NSString * const DMLCarpoolFridayStartingTimeKey = @"fri_time";
NSString * const DMLCarpoolSaturdayStartingTimeKey = @"sat_time";
NSString * const DMLCarpoolSundayStartingTimeKey = @"sun_time";

@implementation DMLCarpool

#pragma mark - Attributes

-(void)updateWithAttributes:(NSDictionary *)attributes {
    
    if ([self attributesKey:DMLCarpoolIdentifierKey canBeUpdatedFromAttributes:attributes]) {
        
        _identifier = [[attributes valueForKeyPath:DMLCarpoolIdentifierKey] integerValue];
        
    }
    
    if ([self attributesKey:DMLCarpoolCodeKey canBeUpdatedFromAttributes:attributes]) {
        
        _code = [attributes valueForKeyPath:DMLCarpoolCodeKey];
        
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
    
    if ([self attributesKey:DMLCarpoolMondayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _mondayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolMondayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolTuesdayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _tuesdayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolTuesdayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolWednesdayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _wednesdayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolWednesdayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolThursdayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _thursdayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolThursdayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolFridayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _fridayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolFridayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolSaturdayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _saturdayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolSaturdayStartingTimeKey] integerValue]);
        
    }
    
    if ([self attributesKey:DMLCarpoolSundayStartingTimeKey canBeUpdatedFromAttributes:attributes]) {
        
        _sundayStartingTime = @([[attributes valueForKeyPath:DMLCarpoolSundayStartingTimeKey] integerValue]);
        
    }
    
}

#pragma mark - Carpools

+(void)createCarpoolWithName:(NSString *)name completionBlock:(void (^)(NSString *code))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *parameters = @{ @"name" : name ?: @"dank memes" };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/carpools/create.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *results) {
        
        completionBlock ? completionBlock(results[@"code"]) : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failedBlock ? failedBlock(error) : nil;
        
    }];
    
}

+(void)joinCarpoolWithCode:(NSString *)code completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *parameters = @{ @"code" : code ?: @"dank memes" };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/carpools/join.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
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

#pragma mark - Editing

-(void)editWithName:(NSString *)name mondayStartingTime:(NSNumber *)mondayStartingTime tuesdayStartingTime:(NSNumber *)tuesdayStartingTime wednesdayStartingTime:(NSNumber *)wednesdayStartingTime thursdayStartingTime:(NSNumber *)thursdayStartingTime fridayStartingTime:(NSNumber *)fridayStartingTime saturdayStartingTime:(NSNumber *)saturdayStartingTime sundayStartingTime:(NSNumber *)sundayStartingTime completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSDictionary *attributes = @{
                                 @"carpool_id" : @([self identifier]),
                                 DMLCarpoolNameKey : name ?: @"lol oof",
                                 DMLCarpoolMondayStartingTimeKey : mondayStartingTime ?: @(0),
                                 DMLCarpoolTuesdayStartingTimeKey : thursdayStartingTime ?: @(0),
                                 DMLCarpoolWednesdayStartingTimeKey : wednesdayStartingTime ?: @(0),
                                 DMLCarpoolThursdayStartingTimeKey : thursdayStartingTime ?: @(0),
                                 DMLCarpoolFridayStartingTimeKey : fridayStartingTime ?: @(0),
                                 DMLCarpoolSaturdayStartingTimeKey : saturdayStartingTime ?: @(0),
                                 DMLCarpoolSundayStartingTimeKey : sundayStartingTime ?: @(0),
    };
    [[DMLHTTPRequestOperationManager manager] POST:@"api/carpools/edit.php" parameters:attributes success:^(AFHTTPRequestOperation *operation, NSArray *results) {
        
        completionBlock ? completionBlock() : nil;
        
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
