//
//  DMLNotificationManager.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLNotificationManager.h"
#import "DMLUser.h"

@implementation DMLNotificationManager

#pragma mark - Push Tokens

-(void)registerPushToken:(NSString *)pushToken {
    
    NSString *normalizedToken = [pushToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    normalizedToken = [normalizedToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    _pushToken = normalizedToken;
    
    [[DMLUser me] updatePushToken:normalizedToken completionBlock:^{
        
        NSLog(@"Push token updated.");
        
    } failedBlock:^(NSError *error) {
        
        NSLog(@"Push token failed to update with error: %@",error);
        
    }];
    
}

#pragma mark - Registration

-(void)registerForPushNotifications {
    
    UIUserNotificationType notificationTypes = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
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
