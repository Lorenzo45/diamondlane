//
//  DMLCarpoolTableViewCell.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolTableViewCell.h"

#import "DMLCarpool.h"

@implementation DMLCarpoolTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
    
}

-(void)prepareForReuse {
    
    [super prepareForReuse];
    
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    
}

#pragma mark - Getters & Setters

-(void)setCarpool:(DMLCarpool *)carpool {
    
    _carpool = carpool;
    [self setNeedsLayout];
    
}

#pragma mark - Class Methods

+(CGFloat)heightForCarpool:(DMLCarpool *)carpool {
    
    return 50.0;
    
}

@end
