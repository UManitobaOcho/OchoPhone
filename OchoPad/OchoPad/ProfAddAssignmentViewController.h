//
//  ProfAddAssignmentViewController.h
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-0.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "ProfAssignment.h"
#import "CourseDetailsViewController.h"

@class ProfAssignment;

@interface ProfAddAssignmentViewController : UIViewController

@property(nonatomic) Course *currCourse;

@property (strong, nonatomic) IBOutlet UITextField *AssignmentNameBox;

@property (strong, nonatomic) IBOutlet UILabel *AssignmentNameError;

@property (strong, nonatomic) IBOutlet UIDatePicker *ReleaseDatePicker;

@property (strong, nonatomic) IBOutlet UILabel *ReleaseDateError;

@property (strong, nonatomic) IBOutlet UIDatePicker *DueDatePicker;

@property (strong, nonatomic) IBOutlet UILabel *DueDateError;

@property (strong, nonatomic) IBOutlet UISegmentedControl *FileInputSwitcher;

@property (strong, nonatomic) IBOutlet UITextView *FileInputBox;

@property (strong, nonatomic) IBOutlet UILabel *FileInputError;

@property (strong, nonatomic) IBOutlet UILabel *UploadMessage;

- (IBAction)done:(id)sender;

- (bool)verifyAssignment;

@end
