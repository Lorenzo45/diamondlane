//
//  DMLSetTimeViewController.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-20.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMLTimeSetterProtocol <NSObject>

@required
- (void)didUpdateTime:(NSDate *)date;

@end

@interface DMLSetTimeViewController : UIViewController

@property (nonatomic, weak) id <DMLTimeSetterProtocol> delegate;

@end
