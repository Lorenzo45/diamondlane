//
//  DMLNoCarpoolsViewController.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMLNoCarpoolsViewControllerDelegate;

@interface DMLNoCarpoolsViewController : UIViewController

@property (nonatomic, weak) id <DMLNoCarpoolsViewControllerDelegate> delegate;

@end

@protocol DMLNoCarpoolsViewControllerDelegate <NSObject>

@required
-(void)noCarpoolsViewControllerDidCreateCarpool:(DMLNoCarpoolsViewController *)createCarpoolViewController;

@end
