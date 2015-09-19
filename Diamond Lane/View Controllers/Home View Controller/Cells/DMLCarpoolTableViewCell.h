//
//  DMLCarpoolTableViewCell.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMLCarpool;

@interface DMLCarpoolTableViewCell : UITableViewCell

@property (nonatomic, strong) DMLCarpool *carpool;

+(CGFloat)heightForCarpool:(DMLCarpool *)carpool;

@end
