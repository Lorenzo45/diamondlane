//
//  DMLCarpoolListViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolListViewController.h"

#import "DMLCarpoolTableViewCell.h"

@interface DMLCarpoolListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly, strong) UITableView *tableView;

@end

@implementation DMLCarpoolListViewController

@synthesize tableView=_tableView;
-(UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView registerClass:[DMLCarpoolTableViewCell class] forCellReuseIdentifier:@"Cell"];
        [[self view] addSubview:_tableView];
        
    }
    return _tableView;
   
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpool *carpool = nil;
    return [DMLCarpoolTableViewCell heightForCarpool:carpool];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
