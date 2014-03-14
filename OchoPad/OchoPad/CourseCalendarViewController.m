//
//  CourseCalendarViewController.m
//  OchoPad
//
//  Created by Alexander Plishka on 2014-03-14.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "CourseCalendarViewController.h"
#import "TSQCalendarView.h"
#import "TSQTACalendarRowCell.h"

@interface CourseCalendarViewController()
@end

@implementation CourseCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TSQCalendarView *calendarView = [[TSQCalendarView alloc] init];
    calendarView.calendar = self.calendar;
    calendarView.rowCellClass = [TSQTACalendarRowCell class];
    calendarView.firstDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 0];
    calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 0.1];
    calendarView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    
    self.view = calendarView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
