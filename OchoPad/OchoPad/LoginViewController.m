//
//  LoginViewController.m
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-20.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "LoginViewController.h"
#import "CourseViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ProfessorSegue"]){
        CourseViewController *controller = (CourseViewController *)segue.destinationViewController;
        controller.courses = self.courses;
        controller.isProf = YES;
    }
    else if([segue.identifier isEqualToString:@"StudentSegue"]){
        CourseViewController *controller = (CourseViewController *)segue.destinationViewController;
        controller.courses = self.courses;
        controller.isProf = NO;
    }
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

@end
