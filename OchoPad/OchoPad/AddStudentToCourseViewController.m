//
//  AddStudentToCourseViewController.m
//  OchoPad
//
//  Created by Jasdeep Singh Bhumber on 2014-03-11.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "AddStudentToCourseViewController.h"
#import "ComInterface.h"

@interface AddStudentToCourseViewController ()

@end

@implementation AddStudentToCourseViewController

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
    
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.currCourse.course_id, @"course", nil];
                          
                          //profAssignment.AssignmentName, @"assignmentTitle", profAssignment.CourseNumber, @"course", profAssignment.ReleaseDate, @"releaseDate", profAssignment.DueDate, @"dueDate", profAssignment.file, @"file", nil];
    
    [mySocketIO sendEvent:@"getStudNotInCourse" withData:data];
    NSLog(@"successful");
    
	// Do any additional setup after loading the view.
}
- (void)receivedPacket:(id)packet
{
    
    if([packet[@"name"] isEqual: @"foundStudNotInCourse"])
    {
        NSLog(@"Found data");
    }

    
}
- (void) addStudent
{
    NSLog(@"Made to student");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
