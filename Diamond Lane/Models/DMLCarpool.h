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
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *code;
@property (nonatomic, readonly, strong) NSArray <DMLUser *> *members;

@property (nonatomic, readonly, assign) NSNumber *mondayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *tuesdayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *wednesdayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *thursdayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *fridayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *saturdayStartingTime;
@property (nonatomic, readonly, assign) NSNumber *sundayStartingTime;

-(void)editWithName:(NSString *)name mondayStartingTime:(NSNumber *)mondayStartingTime tuesdayStartingTime:(NSNumber *)tuesdayStartingTime wednesdayStartingTime:(NSNumber *)wednesdayStartingTime thursdayStartingTime:(NSNumber *)thursdayStartingTime fridayStartingTime:(NSNumber *)fridayStartingTime saturdayStartingTime:(NSNumber *)saturdayStartingTime sundayStartingTime:(NSNumber *)sundayStartingTime completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
-(void)refreshMembersWithCompletionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
-(void)reportLeavingAsDriverWithCompletionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
-(void)reportArrivingAt:(DMLUser *)user completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(void)createCarpoolWithName:(NSString *)name completionBlock:(void (^)(NSString *code))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
+(void)joinCarpoolWithCode:(NSString *)code completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
+(void)fetchCarpoolsWithCompletionBlock:(void (^)(NSArray *carpools))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(instancetype)carpoolWithAttributes:(NSDictionary *)attributes;

@end
