//
//  ProfAddAssignmentViewController.m
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "ProfAddAssignmentViewController.h"

@interface ProfAddAssignmentViewController ()

@end

@implementation ProfAddAssignmentViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    ProfAssignment *profAssignment = [[ProfAssignment alloc] init];
    profAssignment.AssignmentName = self.AssignmentNameBox.text;
    profAssignment.CourseNumber = self.currCourse.number;
    profAssignment.ReleaseDate = @"";
    profAssignment.DueDate = @"";
    
    NSLog(@"%@",profAssignment.AssignmentName);
    NSLog(@"%@",profAssignment.CourseNumber);
    NSLog(@"%@",profAssignment.ReleaseDate);
    NSLog(@"%@",profAssignment.DueDate);
}


@end
