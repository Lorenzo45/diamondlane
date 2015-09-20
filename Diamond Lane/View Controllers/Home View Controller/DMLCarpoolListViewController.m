//
//  DMLCarpoolListViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolListViewController.h"

#import "DMLCarpoolDetailViewController.h"
#import "DMLCarpoolTableViewCell.h"
#import "DMLCarpool.h"
#import "DMLUser.h"

#define CELL_ID @"DMLCarpoolTableViewCell"

@interface DMLCarpoolListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly, strong) UITableView *tableView;

@end

@implementation DMLCarpoolListViewController

@synthesize tableView=_tableView;
-(UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView registerNib:[UINib nibWithNibName:CELL_ID bundle:nil] forCellReuseIdentifier:CELL_ID];
        [_tableView setEstimatedRowHeight:44.0];
        [[self view] addSubview:_tableView];
        
    }
    return _tableView;
   
}

- (void)setCarpools:(NSArray *)carpools {
    
    _carpools = carpools;
    
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.carpools.count;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    DMLCarpool *carpool = nil;
//    return [DMLCarpoolTableViewCell heightForCarpool:carpool];
//    
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    DMLCarpool *carpoolObj = self.carpools[indexPath.row];
    
    if ([cell isKindOfClass:[DMLCarpoolTableViewCell class]] && [carpoolObj isKindOfClass:[DMLCarpool class]]) {
        
        DMLCarpoolTableViewCell *carpoolCell = (DMLCarpoolTableViewCell *)cell;
        DMLCarpool *carpool = (DMLCarpool *)carpoolObj;
        
        carpoolCell.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)carpool.identifier];
        carpoolCell.passengersLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)carpool.members.count, carpool.members.firstObject.description];
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpoolDetailViewController *detailViewController = [[DMLCarpoolDetailViewController alloc] init];
    detailViewController.carpool = self.carpools[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
