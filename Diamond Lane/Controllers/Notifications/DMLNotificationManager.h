//
//  DMLNotificationManager.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMLNotificationManager : NSObject

@property (nonatomic, readonly, copy) NSString *pushToken;
-(void)registerPushToken:(NSString *)pushToken;

-(void)registerForPushNotifications;

+(instancetype)sharedInstance;

@end
