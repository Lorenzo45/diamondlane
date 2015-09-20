//
//  DMLJoinViewController.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMLJoinCarpoolViewControllerDelegate;

@interface DMLJoinViewController : UIViewController

@property (nonatomic, weak) id <DMLJoinCarpoolViewControllerDelegate> delegate;

@end

@protocol DMLJoinCarpoolViewControllerDelegate <NSObject>

@required
-(void)joinCarpoolViewControllerDidCreateCarpool:(DMLJoinViewController *)joinCarpoolViewController;

@end

