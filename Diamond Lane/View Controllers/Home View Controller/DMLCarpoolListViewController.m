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
#import "DMLJoinViewController.h"
#import "DMLCreateCarpoolViewController.h"

#define CELL_ID @"DMLCarpoolTableViewCell"

@interface DMLCarpoolListViewController () <UITableViewDataSource, UITableViewDelegate, DMLCreateCarpoolViewControllerDelegate>

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

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddMenu)];
        
    }
    return self;
    
}

- (void)showAddMenu {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Add a Carpool" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *join = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UINavigationController *navController = [[UINavigationController alloc] init];
        navController.viewControllers = @[[[DMLJoinViewController alloc] init]];
        [self presentViewController:navController  animated:YES completion:nil];
        
    }];
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DMLCreateCarpoolViewController *createCarpoolViewController = [[DMLCreateCarpoolViewController alloc] init];
        [createCarpoolViewController setDelegate:self];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createCarpoolViewController];
        [self presentViewController:navController  animated:YES completion:nil];
        
    }];
    
    [actionSheet addAction:cancel];
    [actionSheet addAction:join];
    [actionSheet addAction:create];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - DMLCreateCarpoolViewControllerDelegate

-(void)createCarpoolViewControllerDidCreateCarpool:(DMLCreateCarpoolViewController *)createCarpoolViewController {
    
    [DMLCarpool fetchCarpoolsWithCompletionBlock:^(NSArray *carpools) {
        self.carpools = carpools;
    } failedBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.carpools.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    DMLCarpool *carpoolObj = self.carpools[indexPath.row];
    
    if ([cell isKindOfClass:[DMLCarpoolTableViewCell class]] && [carpoolObj isKindOfClass:[DMLCarpool class]]) {
        
        DMLCarpoolTableViewCell *carpoolCell = (DMLCarpoolTableViewCell *)cell;
        DMLCarpool *carpool = (DMLCarpool *)carpoolObj;
        
        carpoolCell.titleLabel.text = carpool.name;
        carpoolCell.passengersLabel.text = [self namesOfCarpoolMemebers:carpool.members];
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DMLCarpoolDetailViewController *detailViewController = [[DMLCarpoolDetailViewController alloc] init];
    detailViewController.carpool = self.carpools[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (NSString *)namesOfCarpoolMemebers:(NSArray <DMLUser *> *)members {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (DMLUser *member in members) {
        [names addObject:member.name];
    }
    return [names componentsJoinedByString:@", "];
}

@end
