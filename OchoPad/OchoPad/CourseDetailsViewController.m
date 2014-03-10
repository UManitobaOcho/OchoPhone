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
    
    mainArray = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
	// Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [mainArray objectAtIndex:indexPath.row];
    return cell;
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
    course.section = self.sectionTextField.text;
    
    if([self.onlineSwitch isOn]) {
        course.class_times = @"Online";
    } else {
        NSLog(@"off");
    }
    
    [self.delegate courseDetailsViewController:self didAddCourse:course];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate courseDetailsViewControllerDidCancel:self];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//    } else {
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//}

@end
