//
//  DMLCarpool.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLModel.h"
#import "DMLObjectStore.h"

@class DMLUser;

@interface DMLCarpool : NSObject <DMLModel, DMLPersistentObject>

@property (nonatomic, readonly, assign) NSInteger identifier;
@property (nonatomic, readonly, strong) NSArray <DMLUser *> *members;

-(void)refreshMembersWithCompletionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(void)fetchCarpoolsWithCompletionBlock:(void (^)(NSArray *carpools))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(instancetype)carpoolWithAttributes:(NSDictionary *)attributes;

@end
