//
//  DMLCarpoolListViewController.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMLCarpoolListViewControllerDelegate;

@interface DMLCarpoolListViewController : UIViewController

@property (nonatomic, weak) id <DMLCarpoolListViewControllerDelegate> delegate;

@property (strong, nonatomic) NSArray *carpools;

@end

@protocol DMLCarpoolListViewControllerDelegate <NSObject>

@required
-(void)carpoolListViewController:(DMLCarpoolListViewController *)carpoolListViewController didUpdateCarpools:(NSArray *)carpools;

@end
