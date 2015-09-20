//
//  DMLCarpoolDetailViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolDetailViewController.h"

#import "DMLPassengerTableViewCell.h"
#import "DMLOpenTableViewCell.h"
#import "DMLCodeTableViewCell.h"
#import "DMLScheduleTableViewCell.h"
#import "DMLUser.h"
#import "DMLSetTimeViewController.h"

#define PASSENGER_CELL @"DMLPassengerTableViewCell"
#define OPEN_CELL @"DMLOpenTableViewCell"
#define CODE_CELL @"DMLCodeTableViewCell"
#define SCHEDULE_CELL @"DMLScheduleTableViewCell"

@interface DMLCarpoolDetailViewController () <UITableViewDataSource, UITableViewDelegate, DMLTimeSetterProtocol>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSArray *infoCellIds;
@property (strong, nonatomic) NSArray *days;
@property (strong, nonatomic) NSMutableArray *updatedTimes;
@property (nonatomic) int selectedDayIndex;

@end

@implementation DMLCarpoolDetailViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sectionTitles = @[@"Members", @"Info", @"Schedule"];
        self.infoCellIds = @[OPEN_CELL, CODE_CELL];
        self.days = @[@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.estimatedRowHeight = 44.0;
        [self.view addSubview:self.tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:PASSENGER_CELL bundle:nil] forCellReuseIdentifier:PASSENGER_CELL];
        [self.tableView registerNib:[UINib nibWithNibName:OPEN_CELL bundle:nil] forCellReuseIdentifier:OPEN_CELL];
        [self.tableView registerNib:[UINib nibWithNibName:CODE_CELL bundle:nil] forCellReuseIdentifier:CODE_CELL];
        [self.tableView registerNib:[UINib nibWithNibName:SCHEDULE_CELL bundle:nil] forCellReuseIdentifier:SCHEDULE_CELL];
        
        self.updatedTimes = [[NSMutableArray alloc] initWithCapacity:7];
        for (int i = 0; i < 7; i++) {
            NSNumber *time = [self startingTimeForDayIndex:i];
            if (time == nil || time < 0) {
                time = @0;
            }
            self.updatedTimes[i] = time;
        }
    }
    return self;
    
}

- (void)setCarpool:(DMLCarpool *)carpool {
    
    _carpool = carpool;
    
    self.title = carpool.name;
    [self.tableView reloadData];
    
}

#pragma mark - DMLTimeSetterProtocol

- (void)didUpdateTime:(NSDate *)date {
    NSLog(@"%d", self.selectedDayIndex);
    NSNumber *minutes = [self timeInMinutesFromDate:date];
    self.updatedTimes[self.selectedDayIndex] = minutes;
    NSLog(@"%@", self.updatedTimes);
    [self.tableView reloadData];
    
}

- (NSNumber *)timeInMinutesFromDate:(NSDate *)date {
    
    unsigned hourAndMinuteFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents* travelDateTimeComponents = [calendar components:hourAndMinuteFlags fromDate:date];
    NSInteger hours = [travelDateTimeComponents hour];
    NSInteger minutes = [travelDateTimeComponents minute];
    return @(hours * 60 + minutes);
    
}

- (NSString *)timeFromMinutes:(NSNumber *)minutes {
    
    if (minutes < 0) {
        minutes = @0;
    }
    
    int mins = (int)minutes % 60;
    int hours = (int)minutes / 60;
    
    if (hours > 12) {
        return [NSString stringWithFormat:@"%d:%02d PM", hours % 12, mins];
    } else {
        return [NSString stringWithFormat:@"%d:%02d AM", hours, mins];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.carpool.members.count;
            break;
            
        case 1:
            return self.infoCellIds.count;
            break;
            
        case 2:
            return self.days.count;
            break;
            
        default:
            return 0;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionTitles[section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:PASSENGER_CELL forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[DMLPassengerTableViewCell class]]) {
            
            DMLPassengerTableViewCell *passengerCell = (DMLPassengerTableViewCell *)cell;
            passengerCell.nameLabel.text = self.carpool.members[indexPath.row].name;
            
        }
        
    } else if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:self.infoCellIds[indexPath.row] forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[DMLCodeTableViewCell class]]) {
            
            DMLCodeTableViewCell *codeCell = (DMLCodeTableViewCell *)cell;
            codeCell.carpoolCodeLabel.text = self.carpool.code;
            
        }
        
    } else if (indexPath.section == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:SCHEDULE_CELL forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[DMLScheduleTableViewCell class]]) {
            
            DMLScheduleTableViewCell *scheduleCell = (DMLScheduleTableViewCell *)cell;
            scheduleCell.textLabel.text = self.days[indexPath.row];
            scheduleCell.detailTextLabel.text = [self timeFromMinutes:self.updatedTimes[indexPath.row]];
            scheduleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
    }
    
    if (indexPath.section != 2) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    return cell;
}

- (NSNumber *)startingTimeForDayIndex:(int)dayIndex {
    
    switch (dayIndex) {
        case 0: return self.carpool.sundayStartingTime;
        case 1: return self.carpool.mondayStartingTime;
        case 2: return self.carpool.tuesdayStartingTime;
        case 3: return self.carpool.wednesdayStartingTime;
        case 4: return self.carpool.thursdayStartingTime;
        case 5: return self.carpool.fridayStartingTime;
        case 6: return self.carpool.saturdayStartingTime;
        default: return @-1;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if ([cell isKindOfClass:[DMLCodeTableViewCell class]]) {
        
        DMLCodeTableViewCell *codeCell = (DMLCodeTableViewCell *)cell;
        codeCell.infoLabel.text = @"Copied!";
        [UIPasteboard generalPasteboard].string = codeCell.carpoolCodeLabel.text;
        
    }
    
    if (indexPath.section == 2) {
        
        DMLSetTimeViewController *setTimeViewController = [[DMLSetTimeViewController alloc] init];
        setTimeViewController.title = self.days[indexPath.row];
        setTimeViewController.delegate = self;
        [self.navigationController pushViewController:setTimeViewController animated:YES];
        self.selectedDayIndex = indexPath.row;
        
    }
    
}

@end
