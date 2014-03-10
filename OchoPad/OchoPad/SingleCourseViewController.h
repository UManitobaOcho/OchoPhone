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

@class SingleCourseViewController;

@protocol SingleCourseViewControllerDelegate <NSObject>
- (void)singleCourseViewControllerDidCancel:(SingleCourseViewController *)controller;
- (void)singleCourseViewController:(SingleCourseViewController *)controller didUpdateCourse:(Course *)course;
@end

@interface SingleCourseViewController : UIViewController
@property(nonatomic) Course *currCourse;
@property (strong, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITextField *courseNumber;
@property (weak, nonatomic) IBOutlet UITextField *section;
@property (weak, nonatomic) IBOutlet UISwitch *online;

@property (nonatomic, weak) id <SingleCourseViewControllerDelegate> delegate;

- (IBAction)update:(id)sender;

@end
