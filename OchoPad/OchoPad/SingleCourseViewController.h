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
#import "RemoveStudentToCourseViewController.h"

@class SingleCourseViewController;

@protocol SingleCourseViewControllerDelegate <NSObject>
- (void)singleCourseViewControllerDidCancel:(SingleCourseViewController *)controller;
- (void)singleCourseViewController:(SingleCourseViewController *)controller didUpdateCourse:(Course *)course;
@end

@interface SingleCourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) Course *currCourse;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UpdateButton;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *mainArray;

@property (strong, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewer;
@property (strong, nonatomic) IBOutlet UITextField *courseNumber;
@property (strong, nonatomic) IBOutlet UITextField *section;
@property (strong, nonatomic) IBOutlet UISwitch *online;
@property (strong, nonatomic) IBOutlet UIDatePicker *startTime;
@property (strong, nonatomic) IBOutlet UIDatePicker *endTime;
@property (strong, nonatomic) IBOutlet UILabel *nameError;
@property (strong, nonatomic) IBOutlet UILabel *numberError;
@property (strong, nonatomic) IBOutlet UILabel *sectionError;
@property (strong, nonatomic) IBOutlet UILabel *daysError;
@property (strong, nonatomic) IBOutlet UILabel *timesError;

@property (weak, nonatomic) IBOutlet UIButton *StudentButton;
@property (weak, nonatomic) IBOutlet UIButton *AssignmentButton;
@property (weak, nonatomic) IBOutlet UILabel *AssignmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *StudentLabel;


@property (weak, nonatomic) IBOutlet UISegmentedControl *SelectEditAssignment;

@property (nonatomic, weak) id <SingleCourseViewControllerDelegate> delegate;

@property bool *isProf;

- (NSString *)getClassTimes:(UITableView *)table;
- (bool)validateCourseFields;

@end
