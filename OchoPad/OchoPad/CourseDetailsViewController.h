//
//  CourseDetailsViewController.h
//  OchoPad
//
//  Created by Nico on 2/26/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseDetailsViewController;
@class Course;

@protocol CourseDetailsViewControllerDelegate <NSObject>
- (void)courseDetailsViewControllerDidCancel:(CourseDetailsViewController *)controller;
- (void)courseDetailsViewController:(CourseDetailsViewController *)controller didAddCourse:(Course *)course;
@end

@interface CourseDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *mainArray;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) IBOutlet UITextField *sectionTextField;
@property (strong, nonatomic) IBOutlet UISwitch *onlineSwitch;
@property (strong, nonatomic) IBOutlet UIDatePicker *startTime;
@property (strong, nonatomic) IBOutlet UIDatePicker *endTime;

@property (weak, nonatomic) IBOutlet UILabel *nameError;
@property (weak, nonatomic) IBOutlet UILabel *numberError;
@property (weak, nonatomic) IBOutlet UILabel *sectionError;
@property (weak, nonatomic) IBOutlet UILabel *daysError;
@property (weak, nonatomic) IBOutlet UILabel *timesError;

@property (nonatomic, weak) id <CourseDetailsViewControllerDelegate> delegate;

- (NSString *)getClassTimes:(UITableView *)table;
- (bool)validateCourseFields;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
