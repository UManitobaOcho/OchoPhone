//
//  ProfAddAssignmentViewController.h
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "ProfAssignment.h"
#import "CourseDetailsViewController.h"

@class ProfAssignment;

@interface ProfAddAssignmentViewController : UIViewController

@property(nonatomic) Course *currCourse;

@property (weak, nonatomic) IBOutlet UITextField *AssignmentNameBox;

@property (weak, nonatomic) IBOutlet UIDatePicker *ReleaseDatePicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *DueDatePicker;

- (IBAction)done:(id)sender;

@end
