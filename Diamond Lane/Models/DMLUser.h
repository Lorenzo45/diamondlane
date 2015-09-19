//
//  DMLUser.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLModel.h"
#import "DMLObjectStore.h"

@interface DMLUser : NSObject <DMLModel, DMLPersistentObject>

@property (nonatomic, readonly, assign) NSInteger identifier;

+(void)createUserWithName:(NSString *)name completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(DMLUser *)userWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Me
@interface DMLUser ()

@property (nonatomic, readonly, strong) NSString *authenticationToken;
@property (nonatomic, readonly, assign) BOOL needsAttributesFetch;

+(instancetype)me;

@end
