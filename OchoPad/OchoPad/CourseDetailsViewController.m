//
//  CourseDetailsViewController.m
//  OchoPad
//
//  Created by Nico on 2/26/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "CourseDetailsViewController.h"
#import "Course.h"

@interface CourseDetailsViewController ()

@end

@implementation CourseDetailsViewController

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
    Course *course = [[Course alloc] init];
    course.name = self.nameTextField.text;
    course.number = self.numberTextField.text;
    
    [self.delegate courseDetailsViewController:self didAddCourse:course];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate courseDetailsViewControllerDidCancel:self];
}

@end
