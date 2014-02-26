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

@interface CourseDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (nonatomic, weak) id <CourseDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
