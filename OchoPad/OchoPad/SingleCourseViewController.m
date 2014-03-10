//
//  SingleCourseViewController.m
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "SingleCourseViewController.h"

@interface SingleCourseViewController ()

@end

@implementation SingleCourseViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ProfAddAssignment"]){
        ProfAddAssignmentViewController *controller = (ProfAddAssignmentViewController *)segue.destinationViewController;
        controller.currCourse = self.currCourse;
    }
}

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
    
    _courseName.text = self.currCourse.name;
    _courseNumber.text = self.currCourse.number;
    _section.text = self.currCourse.section;
    
    if([self.currCourse.class_times isEqual:@"Online"]) {
        [_online setOn:YES animated:YES];
    } else {
        [_online setOn:NO animated:NO];
        
        //set time values here
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)update:(id)sender
{
    Course *course = [[Course alloc] init];
    course.name = self.courseName.text;
    course.number = self.courseNumber.text;
    course.section = self.section.text;
    course.course_id = self.currCourse.course_id;
    
    if([self.online isOn]) {
        course.class_times = @"Online";
    } else {
        NSLog(@"off");
    }
    
    [self.delegate singleCourseViewController:self didUpdateCourse:course];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate singleCourseViewControllerDidCancel:self];
}

@end
