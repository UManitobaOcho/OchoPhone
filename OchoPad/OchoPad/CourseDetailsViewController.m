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

- (NSString *)getClassTimes:(UITableView *)table
{
    //create a string with the selected days
    NSString *result = @"";
    NSArray *selectedIndexPaths = [table indexPathsForSelectedRows];
    for(id row in selectedIndexPaths) {
        if([row row] == 0) {
            result = [result stringByAppendingString:@"M"];
        } else if([row row] == 1) {
            result = [result stringByAppendingString:@"T"];
        } else if([row row] == 2) {
            result = [result stringByAppendingString:@"W"];
        } else if([row row] == 3) {
            result = [result stringByAppendingString:@"R"];
        } else if([row row] == 4) {
            result = [result stringByAppendingString:@"F"];
        }
    }
    
    //format the remainder of the string and add in the formatted date value from the time picker
    result = [result stringByAppendingString:@" "];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm aa"];
    
    result = [result stringByAppendingString:[dateFormat stringFromDate:self.startTime.date]];
    result = [result stringByAppendingString:@" - "];
    result = [result stringByAppendingString:[dateFormat stringFromDate:self.endTime.date]];
    
    NSLog(@"string %@", result);
    return result;
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
        course.class_times = [self getClassTimes:tableView];
    }
    
    [self.delegate courseDetailsViewController:self didAddCourse:course];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate courseDetailsViewControllerDidCancel:self];
}


@end
