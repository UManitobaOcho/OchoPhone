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
{
    IBOutlet UITableView *tableView;
    
    NSArray *mainArray;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;
@property (weak, nonatomic) IBOutlet UISwitch *onlineSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *startTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTime;

@property (weak, nonatomic) IBOutlet UILabel *nameError;

@property (nonatomic, weak) id <CourseDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
