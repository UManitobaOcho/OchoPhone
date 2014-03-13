//
//  SingleCourseViewController.h
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "ProfAddAssignmentViewController.h"
#import "AddStudentToCourseViewController.h"

@class SingleCourseViewController;

@protocol SingleCourseViewControllerDelegate <NSObject>
- (void)singleCourseViewControllerDidCancel:(SingleCourseViewController *)controller;
- (void)singleCourseViewController:(SingleCourseViewController *)controller didUpdateCourse:(Course *)course;
@end

@interface SingleCourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
    
    NSArray *mainArray;
}
@property(nonatomic) Course *currCourse;

@property (strong, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITextField *courseNumber;
@property (weak, nonatomic) IBOutlet UITextField *section;
@property (weak, nonatomic) IBOutlet UISwitch *online;
@property (weak, nonatomic) IBOutlet UIDatePicker *startTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTime;

@property (weak, nonatomic) IBOutlet UILabel *nameError;
@property (weak, nonatomic) IBOutlet UILabel *numberError;
@property (weak, nonatomic) IBOutlet UILabel *sectionError;
@property (weak, nonatomic) IBOutlet UILabel *daysError;
@property (weak, nonatomic) IBOutlet UILabel *timesError;

@property (weak, nonatomic) IBOutlet UISegmentedControl *SelectEditAssignment;

@property (nonatomic, weak) id <SingleCourseViewControllerDelegate> delegate;

- (IBAction)update:(id)sender;

@end
