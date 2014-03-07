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
    
    self.label.text = self.currCourse.name;
    self.courseNumber.text = self.currCourse.number;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
